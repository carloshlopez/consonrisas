module ApplicationHelper
  
  ROLES = {:fundation => 1, :provider => 2, :facilitator =>3}
  LANGUAGES = {
  'English' => 'en' ,
  "Espa\xc3\xb1ol" => 'es'
  }
    
  def can_current_member_edit_fundation(fundation_id)
    can_he = true
    can_he = false if current_member.fundation_admins.select{|f| f.fundation.id == fundation_id}.empty?
    can_he
  end
  
  def can_current_member_edit_provider(provider_id)
    can_he = true
    can_he = false if current_member.provider_admins.select{|p| p.provider.id == provider_id}.empty?
    can_he
  end
  
  def can_current_member_edit_event(event_id)
    can_he = true
    can_he = false if current_member.event_admins.select{|e| e.event.id == event_id}.empty?
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
  
  def convert_url_for_href(url)
    href = url
    unless url.starts_with? 'http://'
      href = 'http://' << url
    end
    href
  end
  
  def current_member_has_twitter
    member_signed_in? and !current_member.authentications.select{|a| a.provider == "twitter"}.empty?
  end
  
  def resource_name
    :member
  end
 
  def resource
    @resource ||= Member.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:member]
  end
  
end
