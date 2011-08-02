class SearchController < ApplicationController
  
  def find
    @members = Member.where("email like ?", "%#{params[:find]}%")
    @facilitators = []
    ids = []
    @members.each do |member|
      ids << member.id
    end
    

    @facilitators = Facilitator.where("name like ? AND id NOT IN(?)", "%#{params[:find]}%", ids)
    
    @members.each do |member|
      @facilitators << member.facilitator if member.facilitator
    end
    @providers = Provider.where("name like ?", "%#{params[:find]}%")
    @fundations = Fundation.where("name like ?", "%#{params[:find]}%")
    @events = Event.where("name like ?", "%#{params[:find]}%")
  end

end
