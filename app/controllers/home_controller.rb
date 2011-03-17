class HomeController < ApplicationController
  def index
    @facilitators = Facilitator.count
    @fundations = Fundation.count
    @providers = Provider.count    
    @events = Event.count    
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
