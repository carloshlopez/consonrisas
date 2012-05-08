module FacilitatorsHelper
  def facilitator_name(facilitator)
    if facilitator.name
      facilitator.name
    else
      facilitator.member.email
    end
  end
end
