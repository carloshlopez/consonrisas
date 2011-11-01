class NeedsController < ApplicationController
  before_filter :authenticate_member!
  
  def create
    @event = Event.find(params[:event_id])
    @event.needs.create(params[:need])
    redirect_to event_path(@event)
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    @need = @event.needs.find(params[:id])
    @need.destroy
    respond_to do |format|
      format.json {render :json=>'{"resp":"ok"}'}
    end
  end
  
  def complete
    @need = Need.find(params[:id])
    @need.update_attributes :completed => params[:completed]
    respond_to do |format|
      format.json {render :json=>'{"resp":"ok"}'}
    end
  end

end
