class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  
  #after_create :email_comment
    
  def email_comment
    already_created = []
    self.event.event_facilitators.each do |evnt_fac|
      if(evnt_fac.facilitator.member.emailNotifications) then
      
        worker = MailCommentWorker.new
        worker.subject = I18n.t('events.mail_comment_made_subject')
        worker.comment_by = comment_name
        worker.msg = I18n.t('events.mail_comment_made_msg')
        worker.comment = comment
        worker.event_name = event.name
        worker.event_url = "http://consonrisas.co/events/#{event.id}"
        worker.to = evnt_fac.facilitator.member.email
        worker.queue(:priority=>0)
      end
      #puts("Mensaje enviado a: #{facilitator.member.id}")
      already_created << evnt_fac.facilitator.member.id
    end
    self.event.event_fundations.each do |evnt_fund|
      evnt_fund.fundation.fundation_admins.each do |admin|
        unless already_created.include?(admin.member.id)
          if(admin.active and admin.member.emailNotifications) then
          
            worker = MailCommentWorker.new
            worker.subject = I18n.t('events.mail_comment_made_subject')
            worker.comment_by = comment_name
            worker.msg = I18n.t('events.mail_comment_made_msg')
            worker.comment = comment
            worker.event_name = event.name
            worker.event_url = "http://consonrisas.co/events/#{event.id}"
            worker.to = admin.member.email
            worker.queue(:priority=>0)
          end
          already_created << admin.member.id
          #puts("Mensaje enviado a: #{admin.member.id}")
        end
      end

    end    
    self.event.event_providers.each do |evnt_prov|
      evnt_prov.provider.provider_admins.each do |admin|
        unless already_created.include?(admin.member.id)
          if(admin.active and admin.member.emailNotifications) then
          
            worker = MailCommentWorker.new
            worker.subject = I18n.t('events.mail_comment_made_subject')
            worker.comment_by = comment_name
            worker.msg = I18n.t('events.mail_comment_made_msg')
            worker.comment = comment
            worker.event_name = event.name
            worker.event_url = "http://consonrisas.co/events/#{event.id}"
            worker.to = admin.member.email
            worker.queue(:priority=>0)
          end
          #puts("Mensaje enviado a: #{admin.member.id}")
        end
      end
    end        
  end
  handle_asynchronously :email_comment
  
  private
  
  def comment_name
    if member.facilitator.name
      member.facilitator.name
    else
      member.email
    end
  end
end
