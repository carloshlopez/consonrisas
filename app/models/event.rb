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
  
  after_create :generate_alerts
      
  def ask_admin member_id
    EventAdmin.create(:member_id =>member_id, :event_id => self.id, :active=>false)
  end
  
  def ask_admin_by_mail mail
    EventAdmin.create(:e_mail =>mail, :event_id => self.id, :active=>false)
    # TODO send mail with invitation if email not registered
  end
  
  private 
  
  def at_least_one_fundation
    errors.add_to_base I18n.t('events.one_fundation_error') if self.fundations.blank?
  end
  
  def generate_alerts
    GlobalAlert.create(:news=>"Se creó el evento: ", :model=>"Event", :model_id=>id, :name_link=>name)
  end
  
#  def generate_invites
    
#    already_created = []
#    self.fundations.each do |fundation|
#      Show.find_all_by_population_id(fundation.population.id).each do |show|
#        #puts "UHU NOTICIA PARA PROVEEDOR!!!!! #{show.inspect}"
#        message = I18n.t('events.provider_alert')
#        show.provider.provider_admins.each do |admin|
#          Alert.create(:member_id=> admin.member.id, :news=> message, :link=>self.id)
#          begin
#            if(admin.active and admin.member.emailNotifications) then
#            
#              worker = MailEventCreatedWorker.new
#              worker.subject = I18n.t('events.mail_created_subjet')
#              worker.message = message
#              worker.event_name = name
#              worker.event_url = "http://consonrisas.co/events/#{id}"
#              worker.to = admin.member.email
#              worker.queue(:priority=>0)
#            end
#          rescue => e
#            puts("Error enviando mail en generate_alerts: #{e.message}")
#          end
#          already_created << admin.member.id
#        end
#      end
#      Population.all.each do |pop|
#        #puts "UHU NOTICIA PARA ESTE FACILITADOR!!!!! #{facilitator.inspect}"
#        pop.facilitators.each do |facilitator|
#          unless already_created.include?(facilitator.member.id)
#            message = I18n.t('events.facilitator_alert')
#            Alert.create(:member_id=> facilitator.member.id, :news=> message, :link=>self.id)
#            begin
#              if(facilitator.member.emailNotifications) then
#                worker = MailEventCreatedWorker.new
#                worker.subject = I18n.t('events.mail_created_subjet')
#                worker.message = message
#                worker.event_name = name
#                worker.event_url = "http://consonrisas.co/events/#{id}"
#                worker.to = facilitator.member.email
#                worker.queue(:priority=>0)
#              end
#            rescue => e
#                puts ("Error enviando mail en generate_alerts: #{e.inspect}")
#            end 
#          end          
#        end

#      end      
#    end
#  end
#  handle_asynchronously :generate_alerts
  
  
end
