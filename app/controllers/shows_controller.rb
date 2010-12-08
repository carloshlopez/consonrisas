class ShowsController < ApplicationController
  before_filter :authenticate_member!

  def create
    @provider = Provider.find(params[:provider_id])
    @population = Population.find(params[:population_id])
    @show = @provider.shows.create(params[:show])
    @population.shows.push(@show)
    redirect_to provider_path(@provider) 
  end
  
  def destroy
    @provider = Provider.find(params[:provider_id]) 
    @show = @provider.shows.find(params[:id]) 
    @show.destroy 
    redirect_to provider_path(@provider)  
  end
    
end
