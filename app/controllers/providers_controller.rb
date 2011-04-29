class ProvidersController < ApplicationController

  before_filter :authenticate_member!, :except => [:index]
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
        ProviderAdmin.create(:member_id =>params[:member_id], :provider_id => @provider.id, :active=>true)
        format.html { redirect_to(@provider, :notice => 'Provider was successfully created.') }
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
    respond_to do |format|
      format.json {render :json=> 'ok'}
    end
  end
  
  def remove_follower
    provider = Provider.find(params[:provider_id])
    facilitator = Facilitator.find(params[:facilitator_id])
    provider.facilitators.delete(facilitator)
    respond_to do |format|
      format.json {render :json=> 'ok'}
    end
  end  
  
  def ask_admin
    provider = Provider.find(params[:provider_id])
    provider.ask_admin params[:member_id] if params[:member_id].to_s != "-1" and params[:member_id].to_s != ""
    provider.ask_admin_by_mail params[:mail] if params[:mail].to_s != "mail" and params[:mail].to_s != ""
    respond_to do |format|
      format.js {head :ok}
    end
  end
  
end
