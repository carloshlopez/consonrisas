# coding: utf-8
class ProjectNeedsController < ApplicationController
    #Manage ProjectNeeds, the needs of a Fundation
  
  def create
    @fundation = Fundation.find(params[:fundation_id])
    @need = @fundation.project_needs.create(params[:project_need])
    respond_to do |format|
      format.html {redirect_to(fundation_path(@fundation))}
      format.json {render :json=>@need}
    end
  end
  
  def destroy
    @fundation = Fundation.find(params[:fundation_id])
    @need = @fundation.project_needs.find(params[:id])
    @need.destroy
    respond_to do |format|
      format.json {render :json=>'{"resp":"ok"}'}
    end
  end
  
  def help
    begin
      @fundation = Fundation.find(params[:fundation_id])
      @need = @fundation.project_needs.find(params[:project_need_id])
      @need.help params[:member_id]
      respond_to do |format|
        format.json {render :json=>'{"resp":"ok", "new_state":"'<< @need.state << '"}'}
      end
    rescue Exception => exc
      respond_to do |format|
        format.json {render :json=>'{"resp":"error", "msgs":"Ocurrió un error intenta más tarde"}'}
      end
    end
  end
  
  
  def all_needs
    @need_categories = NeedCategory.all
    @total_needs = ProjectNeed.all.count
    @no_cat_needs = ProjectNeed.where("need_category_id IS NULL")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @need_categories }
    end
  end  
  
  def show
    @need = ProjectNeed.find(params[:id])
    render :layout=>false
  end
    
end
