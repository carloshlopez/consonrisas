class HomeController < ApplicationController
  def index
    @facilitators = Facilitator.count
    @fundations = Fundation.count
    @providers = Provider.count    
  end

end 
