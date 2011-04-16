class HomeController < ApplicationController
  def index
    @facilitators = Facilitator.count
    @fundations = Fundation.count
    @providers = Provider.count    
    @events = Event.count    
    
    @photos = []
    @comments = []
    p_ids = 15.times.map{ rand(Photo.count) }
    p_ids.each do |p_id|
      begin
        @photos << Photo.find(p_id)
      rescue
        
      end
    end        
  end
  
  def event_comments
    @comments = []
    c_ids = 10.times.map{ rand(Comment.count) }
    c_ids.each do |c_id|
      begin
        @comments << Comment.find(c_id)      
      rescue
      end
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
