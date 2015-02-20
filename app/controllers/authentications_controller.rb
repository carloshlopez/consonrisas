#encoding: utf-8

class AuthenticationsController < ApplicationController
  def index
    @authentications = current_member.authentications if current_member
  end

  def create
#    auth = request.env["omniauth.auth"]
#    current_member.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
#    flash[:notice] = "Authentication successful."
#    redirect_to authentications_url
   puts "!!!!!!Aqui tamos!!!!!"
   omniauth = request.env["omniauth.auth"]
   puts "omniauth info: #{omniauth.inspect}"
   session[:fb_token] = omniauth["credentials"]["token"] if omniauth['provider'] == 'facebook'
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:member, authentication.member)
    elsif current_member
      current_member.authentications.create!(:provider => omniauth['provider'], 
          :uid => omniauth['uid'], 
          :token => (omniauth['credentials']['token'] rescue nil),
          :secret => (omniauth['credentials']['secret'] rescue nil))
      current_member.update_attributes(:facebook_id => omniauth['uid']) if omniauth['provider'] == 'facebook'
      flash[:notice] = "Authentication successful."
#      redirect_to authentications_url
      redirect_to edit_member_registration_url
    else

      member = Member.find_by_email(omniauth['user_info']['email']) if omniauth['user_info'] and omniauth['user_info']['email']
      member = Member.new unless member

      member.apply_omniauth(omniauth)
      if member.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:member, member)
      else
        session[:omniauth] = omniauth.except('extra')
#        session[:omniauth] = omniauth
        redirect_to new_member_registration_url
      end
    end
  end

  def destroy
    @authentication = current_member.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
#    redirect_to authentications_url
    redirect_to edit_member_registration_url
  end
  
   def failure
    flash[:notice] = "Falló la autenticacion"
    redirect_to root_path
  end
end
