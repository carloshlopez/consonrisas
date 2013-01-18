# coding: utf-8
class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many :comments
    
  has_many :event_facilitators, :dependent => :destroy
  has_many :event_fundations, :dependent => :destroy
  has_many :event_providers, :dependent => :destroy
  has_and_belongs_to_many :shows, :join_table => :events_shows, :uniq => true  
  has_many :event_admins, :dependent =>:destroy
  has_many :members, :through => :event_admins, :dependent => :destroy  
  has_many :needs, :dependent => :destroy
  attr_accessible :photos_attributes, :videos_attributes, :date, :name, :city, :place, :pic, :isRaiser, :isClosed, :desc
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy=> true
  
  has_many :videos
  accepts_nested_attributes_for :videos, :allow_destroy=> true
  has_attached_file :pic, :styles => {:profile_big => "400x400>", :profile => "150x150>", :thumb => "50x50#"},
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
      if event_facilitators.select{|i| i.facilitator_id == fac_id}.empty?
        event_facilitators.create(:facilitator => Facilitator.find(fac_id), :pending_invitation => true, :is_going => false)
      end
    end
    alert_facilitators facilitators_ids
  end
  
  def add_fundations fundations_ids
    fundations_ids.each do |fund_id|
      if event_fundations.select{|i| i.fundation_id == fund_id}.empty?
        fundation = Fundation.find(fund_id)
        event_fundations.create(:fundation => fundation, :pending_invitation => true, :is_going => false)
      end
    end
    alert_fundations fundations_ids
  end  
  
  def add_providers providers_ids
    providers_ids.each do |prov_id|
      if event_providers.select{|i| i.provider_id == prov_id}.empty?
        prov = Provider.find(prov_id)
        event_providers.create(:provider => prov , :pending_invitation => true, :is_going => false)
      end
    end
    alert_providers providers_ids
  end    
    
  private 
  
  def alert_facilitators facilitators_ids
    facilitators_ids.each do |fac_id|
      facilitator = Facilitator.find(fac_id)
      Alert.create_unique facilitator.member.id, 1, id, fac_id, I18n.t('events.facilitator_invite')
    end
  end
  handle_asynchronously :alert_facilitators  
  
  def alert_fundations fundations_ids
    fundations_ids.each do |fund_id|
      fundation = Fundation.find(fund_id)
      fundation.admin_member_ids.each do |member_id|
        Alert.create_unique member_id, 1, id, fund_id, I18n.t('events.fundation_invite') + fundation.name
      end
    end
  end
  handle_asynchronously :alert_fundations

  def alert_providers providers_ids
    providers_ids.each do |prov_id|
      provider = Provider.find(prov_id)
      provider.admin_member_ids.each do |member_id|
        Alert.create_unique member_id, 1, id, prov_id, I18n.t('events.provider_invite') + provider.name
      end
    end
  end
  handle_asynchronously :alert_providers

  def at_least_one_fundation
    errors.add_to_base I18n.t('events.one_fundation_error') if self.fundations.blank?
  end
  
  def generate_alerts
    GlobalAlert.create(:news=>"Se creó el evento: ", :model=>"Event", :model_id=>id, :name_link=>name)
  end

  def create_fb_event
    begin
      page = FbGraph::Page.new(Consonrisas::Application.config.fb.page_id)
      event = page.event!(:access_token => Consonrisas::Application.config.fb.auth_token, :name => self.name, :start_time => self.date + 5, :location => self.city + " - " + self.place, :description => self.desc + "\r\nMás info en: " + event_url(self))
    rescue => e
      puts "Error posting event to facebook: #{e.inspect}"
    end
  end
  handle_asynchronously :create_fb_event
  
end
