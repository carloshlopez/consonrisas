class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  
  after_create :email_comment
  
  def email_comment
    Thread.new{email_comment_t}
  end
  
  private
  
  def email_comment_t
    already_created = []
    self.event.facilitators.each do |facilitator|
      if(!Rails.env.development?) then
        EventInvitation.event_comment(self, facilitator.member.email, self.event).deliver      
      end
      #puts("Mensaje enviado a: #{facilitator.member.id}")
      already_created << facilitator.member.id
    end
    self.event.fundations.each do |fundation|
      fundation.fundation_admins.each do |admin|
        unless already_created.include?(admin.member.id)
          if(!Rails.env.development?) then
            EventInvitation.event_comment(self, admin.member.email, self.event).deliver if admin.active
          end
          already_created << admin.member.id
          #puts("Mensaje enviado a: #{admin.member.id}")
        end
      end

    end    
    self.event.providers.each do |provider|
      provider.provider_admins.each do |admin|
        unless already_created.include?(admin.member.id)
          if(!Rails.env.development?) then
            EventInvitation.event_comment(self, admin.member.email, self.event).deliver if admin.active
          end
          #puts("Mensaje enviado a: #{admin.member.id}")
        end
      end
    end        
  end
end
