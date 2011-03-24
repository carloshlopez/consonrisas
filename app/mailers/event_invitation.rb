class EventInvitation < ActionMailer::Base
  default :from => "noreply@conectandosonrisas.org"
  
  def invite_facilitator(member, event)
    @member = member
    @message  = I18n.t('events.facilitator_invite')
    @event = event
    mail(:to => member.email,
         :subject => I18n.t('events.mail_invite_subject'))
  end
  
end
