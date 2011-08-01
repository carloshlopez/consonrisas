class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @member.new_record?
  end
  
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @member.apply_omniauth(session[:omniauth])
      @member.valid?
    end
  end
end
