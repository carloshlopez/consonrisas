class ShowsController < ApplicationController
  before_filter :authenticate_member!

  def create
    if current_member.provider.id == params[:provider_id]
      @provider = Provider.find(params[:provider_id])
      @population = Population.find(params[:population_id])
      @show = @provider.shows.create(params[:show])
      @population.shows.push(@show)
    
      redirect_to provider_path(@provider) and return
    end
    @notice = "You can't edit other providers shows"
    redirect_to root_url
  end
  
  def destroy
    if current_member.provider.id == params[:provider_id]
      @provider = Provider.find(params[:provider_id]) 
      @show = @provider.shows.find(params[:id]) 
      @show.destroy 
      redirect_to provider_path(@provider)  
    end
    @notice = "You can't edit other providers shows"
    redirect_to root_url
  end
    
end
