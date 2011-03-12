module ApplicationHelper
  
  ROLES = {:fundation => 1, :provider => 2, :facilitator =>3}
  LANGUAGES = {
  'English' => 'en' ,
  "Espa\xc3\xb1ol" => 'es'
  }
    
  def can_current_member_edit_fundation(fundation_id)
    can_he = true
    can_he = false if current_member.fundations.select{|f| f.id == fundation_id}.empty?
    can_he
  end
  
  def can_current_member_edit_provider(provider_id)
    can_he = true
    can_he = false if current_member.providers.select{|p| p.id == provider_id}.empty?
    can_he
  end
  
  def can_current_member_edit_event(event_id)
    can_he = true
    can_he = false if current_member.events.select{|e| e.id == event_id}.empty?
    can_he
  end
  
  def can_current_member_edit_facilitator(facilitator_id)
    can_he = true
    can_he = false unless current_member.facilitator and current_member.facilitator.id == facilitator_id
    can_he
  end  
  
  def is_current_member_this_member(member_id)
    member_signed_in? and current_member.id == member_id
  end  
  
  def destroy_contact_information(member, contact_information_id, member_type)
    path = ""
    if(member_type.to_i == ROLES[:fundation])
      path = fundation_contact_information_path(member, contact_information_id)
      path = "#{path}?member_type=#{ROLES[:fundation]}"
    elsif(member_type.to_i == ROLES[:provider])
      path = provider_contact_information_path(member, contact_information_id)
      path = "#{path}?member_type=#{ROLES[:provider]}"
    else
      path = member_contact_information_path(member, contact_information_id)
      path = "#{path}?member_type=#{ROLES[:facilitator]}"
    end
    path
  end    
end
