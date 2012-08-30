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
    @facilitators.sort! do |a,b| 
      a.name.nil? ? -1 : b.name.nil? ? 1 : a.name.downcase <=> b.name.downcase 
    end
    @num_facilitators = @facilitators.length

    @providers = Provider.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
    @providers.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @num_providers = @providers.length

    @fundations = Fundation.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
    @fundations.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @num_fundations = @fundations.length

    @events = Event.where("LOWER(name) like ?", "%#{params[:find].downcase}%")
    @events.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @num_events = @events.length
  end

end
