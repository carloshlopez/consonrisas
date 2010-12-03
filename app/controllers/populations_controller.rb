class PopulationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:index, :show]
  # GET /populations
  # GET /populations.xml
  def index
    @populations = Population.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @populations }
    end
  end

  # GET /populations/1
  # GET /populations/1.xml
  def show
    @population = Population.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @population }
    end
  end

  # GET /populations/new
  # GET /populations/new.xml
  def new
    @population = Population.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @population }
    end
  end

  # GET /populations/1/edit
  def edit
    @population = Population.find(params[:id])
  end

  # POST /populations
  # POST /populations.xml
  def create
    @population = Population.new(params[:population])

    respond_to do |format|
      if @population.save
        format.html { redirect_to(@population, :notice => 'Population was successfully created.') }
        format.xml  { render :xml => @population, :status => :created, :location => @population }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @population.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /populations/1
  # PUT /populations/1.xml
  def update
    @population = Population.find(params[:id])

    respond_to do |format|
      if @population.update_attributes(params[:population])
        format.html { redirect_to(@population, :notice => 'Population was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @population.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /populations/1
  # DELETE /populations/1.xml
  def destroy
    @population = Population.find(params[:id])
    @population.destroy

    respond_to do |format|
      format.html { redirect_to(populations_url) }
      format.xml  { head :ok }
    end
  end
end
