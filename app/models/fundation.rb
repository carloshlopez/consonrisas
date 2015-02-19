# encoding: utf-8

# coding: utf-8
class Fundation < ActiveRecord::Base
  belongs_to :population
  has_and_belongs_to_many :populations, :join_table => :fundation_populations, :uniq => true 
  has_many :events_invitations, :foreign_key => "fundation_id", :class_name => "EventFundation", :dependent =>:destroy 
  has_many :events, :through => :events_invitations do
    def attended
      where("is_going = ? and events.date < ?", true, Time.current)
    end

    def is_going
      where("is_going = ? and events.date >= ?", true, Time.current)
    end

    def attended_or_is_going
      where("is_going = ?", true)
    end
  end
  has_many :contact_informations, :dependent => :destroy
  has_and_belongs_to_many :facilitators, :join_table => :fundations_facilitators
  
  has_many :fundation_admins, :dependent =>:destroy
  has_many :members, :through => :fundation_admins, :dependent => :destroy  
  has_many :project_needs, :dependent => :destroy
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :path => "fundations/:attachment/:id/:style/:filename"
  
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']  
  
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 250 }
  
  after_create :generate_alerts
  before_destroy :destroy_fundation_dependencies
  
  def ask_admin member_id
    FundationAdmin.create(:member_id =>member_id, :fundation_id => self.id, :active=>false)
  end
  
  def ask_admin_by_mail mail
    FundationAdmin.create(:e_mail =>mail, :fundation_id => self.id, :active=>false)
  end
  
  def send_msg_to_admins(member_from, message)
#    Thread.new{send_msg_to_admins_t(member_from, message)}
    send_msg_to_admins_t(member_from, message)
  end
  
  def admin_member_ids
    member_ids = Array.new
    fundation_admins.each do |admin|
      begin
        member_ids.push admin.member.id if admin.member and admin.member.id and admin.active
      rescue Exception
        puts "Error no admin de #{admin}"
      end
    end
    member_ids
  end
  
  private
  
  def destroy_fundation_dependencies
    GlobalAlert.destroy_all "model_id = '#{self.id}' AND model = 'Fundation'"
  end
  
  def generate_alerts
    GlobalAlert.create(:news=>"Se creó el proyecto social: ", :model=>"Fundation", :model_id=>id, :name_link=>name)
  end
  
  def send_msg_to_admins_t(member_from, message)
    fundation_admins.each do |admin|
      if admin.active
        Alert.create(:member_id=> admin.member.id, :news=> message, :member_from=>member_from.id, :alert_type=>2)
        begin
          SendMsg.msg_to_fundation_admin(member_from, admin.member, message).deliver if admin.member.emailNotifications
        rescue => e
            puts("Error enviando mail admin fundations: #{e.message}")
        end
      end
    end 
  end  
  
end
