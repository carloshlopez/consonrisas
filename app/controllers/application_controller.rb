class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :authenticate_http
  
  private
  
  def authenticate_http
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'usuario123' && password == 'usuario123'
    end
    warden.custom_failure! if performed?
  end
  
  def set_locale
  # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end
  
  #After registration or login go to the right place
  def after_sign_in_path_for(resource)
#    if resource.is_a?(Member) && resource.is_fundation?
#      if resource.has_fundation_info?
#        fundation_url resource.fundation.id and return
#      else
#        new_fundation_url and return
#      end
#    elsif resource.is_a?(Member) && resource.is_facilitator?
#      if resource.has_facilitator_info?
#        facilitator_url resource.facilitator.id and return
#      else
#        new_facilitator_url and return
#      end
#    elsif resource.is_a?(Member) && resource.is_provider?
#      if resource.has_provider_info?
#        provider_url resource.provider.id and return
#      else
#        new_provider_url and return
#      end
#    else
      root_url 
#    end
  end
  
end
