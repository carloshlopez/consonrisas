class HomeController < ApplicationController
  
  def new_index
    @num_facilitators = Facilitator.count
    @num_fundations = Fundation.count
    @num_providers = Provider.count    
    @num_events = Event.count    
    @comments = []
    @photos = []
    @photos = Photo.find(:all, :order => "id desc", :limit => 15)    
#    p_ids = 15.times.map{ rand(Photo.count) }
#    p_ids.each do |p_id|
#      begin
#        p = Photo.find(p_id)
#        @photos << p if p
#      rescue
#        
#      end
#    end      
  end
  
  def index
    @facilitators = Facilitator.count
    @fundations = Fundation.count
    @providers = Provider.count    
    @events = Event.count    
    
    @photos = []
    @comments = []
    @photos = Photo.find(:all, :order => "id desc", :limit => 15)
#    p_ids = 15.times.map{ rand(Photo.count) }
#    p_ids.each do |p_id|
#      begin
#        p = Photo.find(p_id)
#        @photos << p if p
#      rescue
#        
#      end
#    end      
  end
    
  def event_comments
    @comments = Comment.find(:all, :order => "id desc", :limit => 10)
#    @comments = []
#    c_ids = 10.times.map{ rand(Comment.count) }
#    c_ids.each do |c_id|
#      begin
#        c = Comment.find(c_id)
#        @comments << c if c and c.event
#      rescue
#      end
#    end    
    render :layout => false
  end

  def info
    
  end
  def touch
  end
  
  def legal
  end
  
  def contact
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
  
  def services
  end
  
  def landing
  end
  
  def landing_fundations
    if member_signed_in?
      redirect_to member_path current_member
    else
      @fundation = Fundation.new
      render :layout => "landing"
    end
  end
  
  def landing_facilitators
    if member_signed_in?
      redirect_to member_path current_member
    else
      @facilitator = Facilitator.new
      @total_needs = ProjectNeed.all.count
      @no_cat_needs = ProjectNeed.where("need_category_id IS NULL")
      @need_categories = NeedCategory.all      
      render :layout => "landing"
    end
  end
  
  def landing_providers
    if member_signed_in?
      redirect_to member_path current_member
    else
      @events = Event.order("date DESC").page(params[:page]).per(8)    
      @provider = Provider.new
      render :layout => "landing"
    end
  end    
  
  def mobile
    @events = Event.all
    render :layout => false
  end
  
end 
