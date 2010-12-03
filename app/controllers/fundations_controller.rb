class FundationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:index, :show]
  # GET /fundations
  # GET /fundations.xml
  def index
    @fundations = Fundation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fundations }
    end
  end

  # GET /fundations/1
  # GET /fundations/1.xml
  def show
    @fundation = Fundation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fundation }
    end
  end

  # GET /fundations/new
  # GET /fundations/new.xml
  def new
    @fundation = Fundation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fundation }
    end
  end

  # GET /fundations/1/edit
  def edit
    @fundation = Fundation.find(params[:id])
  end

  # POST /fundations
  # POST /fundations.xml
  def create
    @fundation = Fundation.new(params[:fundation])
    @population = Population.find(params[:population_id])


    respond_to do |format|
      if @fundation.save
        @population.fundations.push(@fundation)
        format.html { redirect_to(@fundation, :notice => 'Fundation was successfully created.') }
        format.xml  { render :xml => @fundation, :status => :created, :location => @fundation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fundation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fundations/1
  # PUT /fundations/1.xml
  def update
    @fundation = Fundation.find(params[:id])

    respond_to do |format|
      if @fundation.update_attributes(params[:fundation])
        format.html { redirect_to(@fundation, :notice => 'Fundation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fundation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fundations/1
  # DELETE /fundations/1.xml
  def destroy
    @fundation = Fundation.find(params[:id])
    @fundation.destroy

    respond_to do |format|
      format.html { redirect_to(fundations_url) }
      format.xml  { head :ok }
    end
  end
end
