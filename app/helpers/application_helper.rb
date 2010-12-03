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
  
  def is_this_facilitator(facilitator_id)
    is_it = false
    if is_current_member_facilitator?
      Facilitator.find(facilitator_id)
    end
    is_it
  end
    
end
