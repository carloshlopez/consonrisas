class ProjectNeedsController < ApplicationController
    #Manage ProjectNeeds, the needs of a Fundation
  
  def create
    @fundation = Fundation.find(params[:fundation_id])
    @fundation.project_needs.create(params[:project_need])
    redirect_to fundation_path(@fundation)
  end
  
  def destroy
    @fundation = Fundation.find(params[:fundation_id])
    @need = @fundation.project_needs.find(params[:id])
    @need.destroy
    respond_to do |format|
      format.json {render :json=>'{"resp":"ok"}'}
    end
  end
end
