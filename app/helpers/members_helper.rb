module MembersHelper
  def member_thumb(facilitator)
    if facilitator.member and facilitator.member.use_facebook_pic and facilitator.member.facebook_id
      "http://graph.facebook.com/#{facilitator.member.facebook_id}/picture"
    else
      facilitator.pic.url(:thumb)
    end
  end
  
  def member_pic(facilitator)
    if facilitator.member and facilitator.member.use_facebook_pic and facilitator.member.facebook_id
      "http://graph.facebook.com/#{facilitator.member.facebook_id}/picture?type=large"
    else 
      facilitator.pic.url(:profile)
    end
  end  
  
  def member_name (member)
    if member.facilitator.name and !member.facilitator.name.empty?
      member.facilitator.name.split[0]
    elsif !member.fundation_admins.empty?
      member.fundation_admins[0].fundation.name.split[0]
    elsif !member.provider_admins.empty?
      member.provider_admins[0].provider.name.split[0]
    else
      member.email
    end
  end
  
  def member_name_complete (member)
    if member.facilitator.name and !member.facilitator.name.empty?
      member.facilitator.name
    elsif !member.fundation_admins.empty?
      member.fundation_admins[0].fundation.name
    elsif !member.provider_admins.empty?
      member.provider_admins[0].provider.name
    else
      member.email
    end
  end  
  
end
