class Alert < ActiveRecord::Base
  belongs_to :member
  validates :news, :presence => true
  def self.create_unique member_id, alert_type, link, role_id, news
	unless Alert.where("link = ':link'", :member_id => member_id, :alert_type=> alert_type, :link=> link, :role_id=> role_id).exists? then
        begin 
          Alert.create!(:member_id=> member_id, :news=> news, :link=> link, :alert_type=> alert_type, :role_id=> role_id) 
          EventInvitation.invite_facilitator(Member.find(member_id), self).deliver 
        rescue Exception => e  
          puts e.message
        end
      end  	
  end  
end
