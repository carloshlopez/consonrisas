module RolesHelper
  def role_name(id)
    if id
      Role.find(id).name
    else
      "undefined"  
    end
  end
end
