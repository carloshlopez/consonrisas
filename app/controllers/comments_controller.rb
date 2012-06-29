class CommentsController < ApplicationController
  before_filter :authenticate_member!
  
  def create
    @event = Event.find(params[:event_id])
    @event.comments.create(params[:comment])
    comment = params[:comment][:comment]
    
 
    
    if !current_member.authentications.select{|a| a.provider == "facebook"}.empty?
      begin
        current_member.facebook.feed!(
        :message => comment, 
        :description => "Averigua como puedes ayuar",
        :picture => "http://www.conectandosonrisas.org/pics/profile/missing.png",
        :icon => "http://www.conectandosonrisas.org/pics/thumb/missing.png",
        :link => "http://www.conectandosonrisas.org/eventos/#{@event.id}",
        :name => "Comentario en un evento de Conectando Sonrisas"
        )
      rescue
        
      end
    end   
    
    if !current_member.authentications.select{|a| a.provider == "twitter"}.empty?
      begin
        current_member.twitter.update(comment[0, 89] << "... http://consonrisas.co/eventos/#{@event.id}  @consonrisas")
      rescue 
        
      end
    end

    
    redirect_to event_path(@event)
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.json {render :json=>'{"resp":"ok"}'}
    end
  end
  
end
