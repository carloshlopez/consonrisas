module ApplicationHelper
  
  ROLES = {:fundation => 1, :provider => 2, :facilitator =>3}
  LANGUAGES = {
  'English' => 'en' ,
  "Espa\xc3\xb1ol" => 'es'
  }
  
  def is_current_member_fundation?
    is_it = false
    is_it = current_member.role_id == ROLES[:fundation] if current_member
    is_it
  end
  def is_current_member_facilitator?
    is_it = false
    is_it = current_member.role_id == ROLES[:facilitator] if current_member
    is_it
  end
  def is_current_member_provider?
    is_it = false
    is_it = current_member.role_id == ROLES[:provider] if current_member
    is_it    
  end
  
  def is_current_member_this_facilitator(facilitator_id)
    is_it = false
    if is_current_member_facilitator?
      is_it = true if current_member.facilitator.id == facilitator_id
    end
    is_it
  end
  
  def is_current_member_this_fundation(fundation_id)
    is_it = false
    if is_current_member_fundation?
      is_it = true if current_member.fundation.id == fundation_id
    end
    is_it
  end
  
  def is_current_member_this_provider(provider_id)
    is_it = false
    if is_current_member_provider?
      is_it = true if current_member.provider.id == provider_id
    end
    is_it
  end
  
  def is_current_member_this_member(member_id)
    is_it = false
    is_it = true if current_member.id == member_id
    is_it
  end  
    
  def current_member_profile
    if is_current_member_facilitator? and current_member.has_facilitator_info?
      facilitator_url current_member.facilitator.id 
    elsif  is_current_member_fundation? and current_member.has_fundation_info?
      fundation_url current_member.fundation.id
    elsif is_current_member_provider? and current_member.has_provider_info?
      provider_url current_member.provider.id
    else
      root_url
    end
  end
  
  
    
end
