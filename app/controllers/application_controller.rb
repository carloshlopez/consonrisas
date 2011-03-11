class ApplicationController < ActionController::Base
  protect_from_forgery :except => :set_locale
  before_filter :set_locale, :authenticate_http
  
  private
  
  def authenticate_http
#    authenticate_or_request_with_http_basic do |user_name, password|
#      user_name == 'usuario123' && password == 'usuario123'
#    end
#    warden.custom_failure! if performed?
  end
  
  def set_locale
  # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end
  
  #After registration or login go to the right place
  def after_sign_in_path_for(resource)
    member_path resource.id
  end
  
  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end  
  
end
