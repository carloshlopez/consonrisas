class FacilitatorsController < ApplicationController
  before_filter :authenticate_member!, :except => [:index, :show]
  # GET /facilitators
  # GET /facilitators.xml
  def index
    @facilitators = Facilitator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facilitators }
    end
  end

  # GET /facilitators/1
  # GET /facilitators/1.xml
  def show
    @facilitator = Facilitator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facilitator }
    end
  end

  # GET /facilitators/new
  # GET /facilitators/new.xml
  def new
    @facilitator = Facilitator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @facilitator }
    end
  end

  # GET /facilitators/1/edit
  def edit
    @facilitator = Facilitator.find(params[:id])
  end

  # POST /facilitators
  # POST /facilitators.xml
  def create
    @facilitator = Facilitator.new(params[:facilitator])

    respond_to do |format|
      if @facilitator.save
        format.html { redirect_to(@facilitator, :notice => 'Facilitator was successfully created.') }
        format.xml  { render :xml => @facilitator, :status => :created, :location => @facilitator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facilitator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /facilitators/1
  # PUT /facilitators/1.xml
  def update
    @facilitator = Facilitator.find(params[:id])

    respond_to do |format|
      if @facilitator.update_attributes(params[:facilitator])
        format.html { redirect_to(@facilitator, :notice => 'Facilitator was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facilitator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /facilitators/1
  # DELETE /facilitators/1.xml
  def destroy
    @facilitator = Facilitator.find(params[:id])
    @facilitator.destroy

    respond_to do |format|
      format.html { redirect_to(facilitators_url) }
      format.xml  { head :ok }
    end
  end
end
