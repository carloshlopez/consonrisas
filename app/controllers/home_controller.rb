class HomeController < ApplicationController
  def index
    @facilitators = Facilitator.count
    @fundations = Fundation.count
    @providers = Provider.count    
    @events = Event.count    
    
    @photos = []
    @comments = []
    Event.find(:all).each do |event|  
      event.photos.each do |photo|
        @photos << photo
        break if @photos.length > 15
      end
      break if @photos.length > 15
    end
  end
  
  def event_comments
    @comments = []
    Event.find(:all).each do |event|  
      event.comments.each do |c|
        @comments << c 
        break if @comments.length > 3
      end      
      break if @comments.length > 3
    end
    render :layout => false
  end

  def info
    
  end
  
  def feedback
    Feedback.create(:message=> params[:men])
    respond_to do |format|
      format.js {head:ok}
    end
  end
end 
