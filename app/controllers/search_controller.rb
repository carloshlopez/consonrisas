class SearchController < ApplicationController
  
  def find
    @members = Member.where("LOWER(email) like ?", "%#{params[:find].downcase}%")
    @facilitators = []
    ids = []
    @members.each do |member|
      ids << member.id
    end
    

    @facilitators = Facilitator.where("LOWER(name) like ? AND id NOT IN(?)", "%#{params[:find].downcase}%", ids)
    
    @members.each do |member|
      @facilitators << member.facilitator if member.facilitator
    end
    @providers = Provider.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
    @fundations = Fundation.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
    @events = Event.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
  end

end
