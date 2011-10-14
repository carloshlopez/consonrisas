class HomeController < ApplicationController
  
  def new_index
    @num_facilitators = Facilitator.count
    @num_fundations = Fundation.count
    @num_providers = Provider.count    
    @num_events = Event.count    
    @comments = []
    @photos = []
    p_ids = 15.times.map{ rand(Photo.count) }
    p_ids.each do |p_id|
      begin
        p = Photo.find(p_id)
        @photos << p if p
      rescue
        
      end
    end      
  end
  
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
        p = Photo.find(p_id)
        @photos << p if p
      rescue
        
      end
    end      
  end
    
  def event_comments
    @comments = []
    c_ids = 10.times.map{ rand(Comment.count) }
    c_ids.each do |c_id|
      begin
        c = Comment.find(c_id)
        @comments << c if c and c.event
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
  
  def social
  end
  
  def allies
  end
  
  def donate
  end  
  
end 
