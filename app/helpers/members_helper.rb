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
      "http://graph.facebook.com/#{@member.facebook_id}/picture?type=large"
    else 
      facilitator.pic.url(:profile)
    end
  end  
end
