class ContactInformationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:create]
  def create
    @member = Member.find(params[:member_id])
    @contact_information = @member.contact_informations.create(params[:contact_information])
    @member.contact_informations.push(@contact_information)
    if @member.is_fundation?
      redirect_to fundation_path(@member.fundation)
    elsif @member.is_facilitator?
      redirect_to facilitador_path(@member.facilitator)
    elsif @member.is_provider?
      redirect_to provider_path(@member.provider)
    else
      redirect_to member_path(@member)
    end
  end
  
  def destroy
    @member = Member.find(params[:member_id])
    @contact_information = @member.contact_informations.find(params[:id])
    @contact_information.destroy
    if @member.is_fundation?
      redirect_to fundation_path(@member.fundation)
    elsif @member.is_facilitator?
      redirect_to facilitador_path(@member.facilitator)
    elsif @member.is_provider?
      redirect_to provider_path(@member.provider)
    else
      redirect_to member_path(@member)
    end
  end
end
