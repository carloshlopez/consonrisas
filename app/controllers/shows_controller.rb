class ShowsController < ApplicationController
  before_filter :authenticate_member!

  def create
    @provider = Provider.find(params[:provider_id])
    @population = Population.find(params[:population_id])
    @show = @provider.shows.create(params[:show])
    @population.shows.push(@show)
    respond_to do |format|
      format.html {redirect_to provider_path(@provider)}
      format.json { render :json => { :resp=> "ok" }}
    end 
  end
  
  def destroy
    @provider = Provider.find(params[:provider_id]) 
    @show = @provider.shows.find(params[:id]) 
    @show.destroy 
    respond_to do |format|
      format.html {redirect_to provider_path(@provider)}
      format.json { render :json => { :resp=> "ok" }}
    end     
  end
    
end
