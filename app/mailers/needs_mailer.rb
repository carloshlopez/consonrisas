# coding: utf-8
class NeedsMailer < ActionMailer::Base
  default :from => "\"Conectando Sonrisas\" <noreply@conectandosonrisas.org>"  
  
  def help_found(member_id, member_admin_id, fundation_id, need)
    @need = need
    @member = Member.find(member_id)
    @member_admin = Member.find(member_admin_id)    
    @fundation = Fundation.find(fundation_id)    
    @message = "Al interesado ya le enviamos un mensaje pero recomendamos que te pongas en contacto con esta persona para que se vuelva una realidad estas ganas de ayudar que tienen, el mail de contacto es: #{@member.email}" 
    @title = 'Hay alguien interesado en ayudarte'
    mail(:to => @member_admin.email,
         :subject => 'Conectando Sonrisas encontró alguien interesado en ayudarte')
  end
  
  def help_found_event(member_id, member_admin_id, event_id, need)
    @need = need
    @member = Member.find(member_id)
    @member_admin = Member.find(member_admin_id)    
    @event = Event.find(event_id)    
    @message = "Al interesado ya le enviamos un mensaje pero recomendamos que te pongas en contacto con esta persona para que se vuelva una realidad estas ganas de ayudar que tienen, el mail de contacto es: #{@member.email}" 
    @title = 'Hay alguien interesado en ayudarte en tu Evento'
    mail(:to => @member_admin.email,
         :subject => 'Conectando Sonrisas encontró alguien interesado en ayudarte')
  end  
  
  def help_found_fundation(member_id, fundation_id, need, fundation_mail)
    @need = need
    @member = Member.find(member_id)
    @fundation = Fundation.find(fundation_id)    
    @message = "Al interesado ya le enviamos un mensaje pero recomendamos que te pongas en contacto con esta persona para que se vuelva una realidad estas ganas de ayudar que tienen, el mail de contacto es: #{@member.email}" 
    @title = 'Hay alguien interesado en ayudarte'
    mail(:to => fundation_mail,
         :subject => 'Conectando Sonrisas encontró alguien interesado en ayudarte')
  end  
  
  def help_reminder(member_id, fundation_id, need)
    @member = Member.find(member_id)
    @need = need
    @fundation = Fundation.find(fundation_id)
    @message = "Le hemos enviado un mail al proyecto social, pero recomendamos ponerse en contacto, el mail del proyecto es: #{@fundation.email}. Los correos de los administradores del proyecto social son:" 
    @fundation.fundation_admins.each do |admin|
      @message << " #{admin.member.email} "
    end
    @title = 'Gracias por ayudar'
    mail(:to => @member.email,
         :subject => 'Gracias por ayudar')
  end
  
  def help_reminder_event(member_id, event_id, need)
    @member = Member.find(member_id)
    @need = need
    @event = Event.find(event_id)
    @message = "Este mail es para recordarte tu interés en ayudar en el Evento: <b>#{@event.name}</b> con la necesidad: <b>#{@need.name}</b>.<br/> Le hemos enviado un mail al proyecto social, comentandole de tu iniciativa de ayudar. Los correos de los organizadores del evento son:" 
    @event.event_admins.each do |admin|
      @message << " #{admin.member.email} "
    end
    @title = 'Gracias por generar sonrisas'
    mail(:to => @member.email,
         :subject => 'Gracias por ayudarnos a generar sonrisas :)')
  end  
  
end
