# coding: utf-8
class Event < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :facilitators, :join_table => :events_facilitators, :uniq => true
  has_and_belongs_to_many :fundations, :join_table => :events_fundations, :uniq => true
  has_and_belongs_to_many :providers, :join_table => :events_providers, :uniq => true  
  has_and_belongs_to_many :shows, :join_table => :events_shows, :uniq => true  
  has_many :event_admins, :dependent =>:destroy
  has_many :members, :through => :event_admins, :dependent => :destroy  
  has_many :needs, :dependent => :destroy
  attr_accessible :photos_attributes, :videos_attributes, :date, :name, :city, :place, :pic, :isRaiser, :isClosed, :desc
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy=> true
  
  has_many :videos
  accepts_nested_attributes_for :videos, :allow_destroy=> true
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "events/:attachment/:id/:style/:filename"
#  process_in_background :pic
#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 4.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']  
  

  validates :name, :presence => true, :length => { :maximum => 100 }  
  validates :city, :presence => true, :length => { :maximum => 100 }  
  validates :place, :presence => true, :length => { :maximum => 200 }  
  validates :date, :presence => true
  validates :name, :uniqueness => {:scope => :date}
  #validate :at_least_one_fundation  
  #validates :fundations, :uniqueness => {:scope => :event_id}
  
  after_create :generate_alerts, :create_fb_event
      
  def ask_admin member_id
    EventAdmin.create(:member_id =>member_id, :event_id => self.id, :active=>false)
  end
  
  def ask_admin_by_mail mail
    EventAdmin.create(:e_mail =>mail, :event_id => self.id, :active=>false)
    # TODO send mail with invitation if email not registered
  end

  def add_facilitators facilitators_ids
    facilitators_ids.each do |fac_id|
      unless facilitators.exists?(fac_id)
        facilitators.push(Facilitator.find(fac_id))
      end
    end
    alert_facilitators facilitators_ids
  end
  
  def add_fundations fundations_ids
    fundations_ids.each do |fund_id|
      unless fundations.exists?(fund_id)
        fundations.push(Fundation.find(fund_id))
      end
    end
  end  
  
  def add_providers providers_ids
    providers_ids.each do |prov_id|
      unless providers.exists?(prov_id)
        providers.push(Provider.find(prov_id))
      end
    end
  end    
    
  private 
  
  def alert_facilitators facilitators_ids
    facilitators_ids.each do |fac_id|
      unless facilitators.exists?(fac_id)
        facilitator = Facilitator.find(fac_id)
        Alert.create(:member_id=> facilitator.member.id, :news=> I18n.t('events.facilitator_invite'), :link=>id) 
        EventInvitation.invite_facilitator(facilitator.member, self).deliver 
        facilitators.push(facilitator)
      end
    end
  end
  handle_asynchronously :alert_facilitators  
  
  def at_least_one_fundation
    errors.add_to_base I18n.t('events.one_fundation_error') if self.fundations.blank?
  end
  
  def generate_alerts
    GlobalAlert.create(:news=>"Se creó el evento: ", :model=>"Event", :model_id=>id, :name_link=>name)
  end

  def create_fb_event
    begin
      page = FbGraph::Page.new(Consonrisas::Application.config.fb.page_id)
      event = page.event!(:access_token => Consonrisas::Application.config.fb.auth_token, :name => self.name, :start_time => self.date, :location => self.city + " - " + self.place)
    rescue => e
      puts "Error posting event to facebook: #{e.inspect}"
    end
  end
  handle_asynchronously :create_fb_event
  
end
