class ContactInformationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:create]
  
  def create
    
    if params[:member_type].to_i == ApplicationHelper::ROLES[:fundation]
      @member = Fundation.find(params[:member_id])
    elsif params[:member_type].to_i == ApplicationHelper::ROLES[:provider]
      @member = Provider.find(params[:member_id])      
    else
      @member = Member.find(params[:member_id])
    end
    
    @contact_information = @member.contact_informations.create(params[:contact_information])
    @member.contact_informations.push(@contact_information)
    
    if params[:member_type].to_i == ApplicationHelper::ROLES[:fundation]
       redirect_to fundation_path(@member) and return
  elsif params[:member_type].to_i == ApplicationHelper::ROLES[:provider]
      redirect_to provider_path(@member) and return
    else
      redirect_to member_path(@member) and return
    end
  end
  
  def destroy
    if params[:member_type].to_i == ApplicationHelper::ROLES[:fundation]
      @member = Fundation.find(params[:fundation_id])
    elsif params[:member_type].to_i == ApplicationHelper::ROLES[:provider]
      @member = Provider.find(params[:provider_id])
    else
      @member = Member.find(params[:member_id])
    end
    
    @contact_information = @member.contact_informations.find(params[:id])
    @contact_information.destroy
    
    if params[:member_type].to_i == ApplicationHelper::ROLES[:fundation]
       redirect_to fundation_path(@member) and return
    elsif params[:member_type].to_i == ApplicationHelper::ROLES[:provider]
      redirect_to provider_path(@member) and return
    else 
      redirect_to member_path(@member) and return
    end
  end
end
