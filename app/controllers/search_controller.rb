class SearchController < ApplicationController
  
  def find
    @facilitators = Facilitator.where("name like ?", "%#{params[:find]}%")
    @members = Member.where("email like ?", "%#{params[:find]}%")
    @members.each do |member|
      @facilitators << member.facilitator if member.facilitator
    end
    @providers = Provider.where("name like ?", "%#{params[:find]}%")
    @fundations = Fundation.where("name like ?", "%#{params[:find]}%")
    @events = Event.where("name like ?", "%#{params[:find]}%")
    
  end

end
