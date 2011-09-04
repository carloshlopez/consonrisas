class NewsController < ApplicationController
  before_filter :authenticate_member!
  # GET /news
  # GET /news.xml
  def index
    if current_member.try(:admin?)    
      @news = News.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @news }
      end
    else
      @news = []
    end

  end

  # GET /news/1
  # GET /news/1.xml
  def show
    if current_member.try(:admin?)    
      @news = News.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @news }
      end
    end 
  end

  # GET /news/new
  # GET /news/new.xml
  def new
    if current_member.try(:admin?)    
      @news = News.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @news }
      end
    end
  end

  # GET /news/1/edit
  def edit
    if current_member.try(:admin?)
      @news = News.find(params[:id])
    end
  end

  # POST /news
  # POST /news.xml
  def create
    if current_member.try(:admin?)    
      @news = News.new(params[:news])

      respond_to do |format|
        if @news.save
          format.html { redirect_to(@news, :notice => 'News was successfully created.') }
          format.xml  { render :xml => @news, :status => :created, :location => @news }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    if current_member.try(:admin?)    
      @news = News.find(params[:id])

      respond_to do |format|
        if @news.update_attributes(params[:news])
          format.html { redirect_to(@news, :notice => 'News was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    if current_member.try(:admin?)
      @news = News.find(params[:id])
      @news.destroy

      respond_to do |format|
        format.html { redirect_to(news_index_url) }
        format.xml  { head :ok }
      end
    end
  end
end
