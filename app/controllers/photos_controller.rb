class PhotosController < ApplicationController
  before_filter :authenticate_member!

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      @event = Event.find(params[:event_id])
      @event.photos << @photo
      render :json => { :pic_path => @photo.photo.url(:thumb).to_s , :name => @photo.photo.instance.attributes["photo_file_name"] }, :content_type => 'text/html'
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end  
 
  def update
    @photo = Photo.new(params[:photo])
    if @photo.save
      @event = Event.find(params[:event_id])
      @event.photos << @photo
      render :json => { :pic_path => @photo.photo.url(:thumb).to_s , :name => @photo.photo.instance.attributes["photo_file_name"] }, :content_type => 'text/html'
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end  
end
