class ProvidersController < ApplicationController

  before_filter :authenticate_member!, :except => [:index, :show]
  # GET /providers
  # GET /providers.xml
  def index
    @providers = Provider.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        format.html { redirect_to(@provider, :notice => 'Provider was successfully created.') }
#        format.html { redirect_to(@provider.member, :notice => 'Provider was successfully created.') }

        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to(@provider, :notice => 'Provider was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    @provider = Provider.find(params[:id])
    member_id = @provider.member_id
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to member_url(member_id) }
      format.xml  { head :ok }
    end
  end
  
  
  def add_follower
    provider = Provider.find(params[:provider_id])
    facilitator = Facilitator.find(params[:facilitator_id])
    provider.facilitators.push(facilitator)
    redirect_to providers_path
  end
  
  def remove_follower
    provider = Provider.find(params[:provider_id])
    facilitator = Facilitator.find(params[:facilitator_id])
    provider.facilitators.delete(facilitator)
    redirect_to providers_path
  end  
  
end
