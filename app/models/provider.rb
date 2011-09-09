class Provider < ActiveRecord::Base
  has_many :shows, :dependent => :destroy  
  has_and_belongs_to_many :events, :join_table => :events_providers, :uniq => true
  has_many :contact_informations, :dependent => :destroy, :dependent => :destroy  
  has_and_belongs_to_many :facilitators, :join_table => :providers_facilitators
  
  has_many :provider_admins, :dependent =>:destroy
  has_many :members, :through => :provider_admins, :dependent => :destroy  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "providers/:attachment/:id/:style/:filename"
  
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']
  
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 250 }
  validates :city, :presence => true, :length => { :maximum => 100 }  
  
  def ask_admin member_id
    ProviderAdmin.create(:member_id =>member_id, :provider_id => self.id, :active=>false)
  end
  
  def ask_admin_by_mail mail
    ProviderAdmin.create(:e_mail =>mail, :provider_id => self.id, :active=>false)
    # TODO send mail with invitation if email not registered
  end
  
  def send_msg_to_admins(member_from, message)
#    Thread.new{send_msg_to_admins_t(member_from, message)}
    send_msg_to_admins_t(member_from, message)
  end
  
  private 
  
  def send_msg_to_admins_t(member_from, message)
    provider_admins.each do |admin|
      if admin.active
        Alert.create(:member_id=> admin.member.id, :news=> message, :member_from=>member_from.id, :alert_type=>2)
        begin
          SendMsg.msg_to_providers_admin(member_from, admin.member, message).deliver if admin.member.emailNotifications
        rescue => e
            puts("Error enviando mail a admin providers: #{e.inspect}")
        end
      end
    end 
  end
  
end
