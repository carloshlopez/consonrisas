class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  
  after_create :email_comment
  
  def email_comment
    self.event.facilitators.each do |facilitator|
      EventInvitation.event_comment(self, facilitator.member.email, self.event).deliver      
    end
    self.event.fundations.each do |fundation|
      fundation.fundation_admins.each do |admin|
        EventInvitation.event_comment(self, admin.member.email, self.event).deliver if admin.active
      end

    end    
    self.event.providers.each do |provider|
      provider.provider_admins.each do |admin|
        EventInvitation.event_comment(self, provider.member.email, self.event).deliver if admin.active
      end
    end        
  end
end
