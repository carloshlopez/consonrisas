class SendMsg < ActionMailer::Base
  default :from => "\"Conectando Sonrisas\" <noreply@conectandosonrisas.org>"
  
  def msg_to_facilitator(member_from, member_to, message)
    @member_to = member_to
    @member_from = member_from
    @message  = message
    @title = I18n.t('events.mail_msg_subject')
    mail(:to => member_to.email,
         :subject => I18n.t('events.mail_msg_subject'))
  end
  
  def msg_to_providers_admin(member_from, member_admin, message)
    @member_admin = member_admin
    @member_from = member_from
    @message  = message
    @title = I18n.t('events.mail_msg_admin_provider_subject')
    mail(:to => member_admin.email,
         :subject => I18n.t('events.mail_msg_admin_provider_subject'))    
  end
  
  def msg_to_fundation_admin(member_from, member_admin, message)
    @member_admin = member_admin
    @member_from = member_from
    @message  = message
    @title = I18n.t('events.mail_msg_admin_fundation_subject')
    mail(:to => member_admin.email,
         :subject => I18n.t('events.mail_msg_admin_fundation_subject'))        
  end
  
  def welcome_msg(member)
    @member = member
    @message = "Bienvenido a esta comunidad virtual, donde podrás ayudar a generar momentos llenos de magia y alegría.<br/> Recuerda llenar los detalles de tu perfil como Facilitador, Proveedor, o Proyecto Social.<br/> Gracias por conectarte para sacarle sonrisas al país".html_safe
    mail(:to => @member.email,
         :subject => 'Bienvenido :)')        
  end
  
end
