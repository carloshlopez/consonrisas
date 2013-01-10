class Facilitator < ActiveRecord::Base
  has_many :events_invitations, :foreign_key => "facilitator_id", :class_name => "EventFacilitator", :dependent =>:destroy 
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
  belongs_to :member
  has_and_belongs_to_many :populations, :join_table => :facilitator_populations, :uniq => true
  has_and_belongs_to_many :fundations, :join_table => :fundations_facilitators, :uniq => true
  has_and_belongs_to_many :providers, :join_table => :providers_facilitators, :uniq => true
  has_and_belongs_to_many :facilitators, :join_table => :facilitators_facilitators, :association_foreign_key=> "followed_id", :uniq => true
  
  has_and_belongs_to_many :project_needs, :join_table => :project_need_facilitators, :uniq => true
  has_and_belongs_to_many :needs, :join_table => :need_facilitators, :uniq => true  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "facilitators/:attachment/:id/:style/:filename"

#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']
  
  def has_complete_info
    is_it = true
    is_it = false unless name
    is_it
  end
  
  def send_msg(alert)
    Alert.new(alert).save!
    begin
      SendMsg.msg_to_facilitator(Member.find(alert["member_from"]), self.member, alert["news"]).deliver if self.member.emailNotifications
    rescue => e
      puts "Error facilittor send_msg: #{e.inspect}"
    end
  end
  handle_asynchronously :send_msg

end
