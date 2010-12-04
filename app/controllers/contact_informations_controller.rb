class ContactInformationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:create]
  def create
    if params[:current_member_id] == params[:member_id]
      @member = Member.find(params[:member_id])
      @contact_information = @member.contact_informations.create(params[:contact_information])
      @member.contact_informations.push(@contact_information)
      if @member.is_fundation?
         redirect_to fundation_path(@member.fundation) and return
      elsif @member.is_facilitator?
        redirect_to facilitador_path(@member.facilitator) and return
      elsif @member.is_provider?
        redirect_to provider_path(@member.provider) and return
      else
        redirect_to member_path(@member) and return
      end
    end
    redirect_to root_url
  end
  
  def destroy
    if params[:current_member_id] == params[:member_id]
      @member = Member.find(params[:member_id])
      @contact_information = @member.contact_informations.find(params[:id])
      @contact_information.destroy
      if @member.is_fundation?
        redirect_to fundation_path(@member.fundation) and return
      elsif @member.is_facilitator?
        redirect_to facilitador_path(@member.facilitator) and return
      elsif @member.is_provider?
        redirect_to provider_path(@member.provider) and return
      else
        redirect_to member_path(@member) and return
      end
    end
    redirect_to root_url
  end
end
