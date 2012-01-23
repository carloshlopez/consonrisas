class EventInvitation < ActionMailer::Base
  default :from => "\"Conectando Sonrisas\" <noreply@conectandosonrisas.org>"
  
  def invite_facilitator(member, event)
    @member = member
    @message  = I18n.t('events.facilitator_invite')
    @event = event
    mail(:to => member.email,
         :subject => I18n.t('events.mail_invite_subject'))
  end
  
  def event_created(email, message, event)
    @message  = message
    @event = event
    mail(:to => email,
         :subject => I18n.t('events.mail_created_subjet'))
  end
  
  def event_created_async(subject, message, event_name, event_url, email)
    @subject = subject
    @message  = message
    @event_name = event_name
    @event_url = event_url
    mail(:to => email, :subject => subject)
  end
  
  def event_comment(comment, email, event)
    @comment  = comment.comment
    @comment_by = comment_name(comment)
    @msg = I18n.t('events.mail_comment_made_msg')
    @event = event
    mail(:to => email,
         :subject => I18n.t('events.mail_comment_made_subject'))    
  end
  
  def event_comment_async(subject, comment_by, msg, comment, event_name, event_url, email)
    @subject = subject
    @comment_by = comment_by
    @msg = msg
    @comment = comment
    @event_name = event_name
    @event_url = event_url
    mail(:to => email, :subject => subject)    
  end
  
  private 
  def comment_name(comment)
    if comment.member.facilitator.name
      comment.member.facilitator.name
    else
      comment.member.email
    end
  end
  
end
