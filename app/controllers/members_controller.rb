class MembersController < ApplicationController
  before_filter :authenticate_member!
  # GET /members
  # GET /members.xml
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    @member = Member.find(params[:id])
    @contact_informations = @member.contact_informations
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.xml
  def create
    @member = Member.new(params[:member])
    respond_to do |format|
      if @member.save 
        format.html { redirect_to(@member, :notice => 'Member was successfully created.') }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(@member, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
  
  def delete_alert
    @alert = Alert.find(params[:alert_id])
    @alert.destroy
    respond_to do |format|
      format.js  { head :ok }      
    end    

  end
  
  def update_facebook_id
    @member = Member.find(params[:member_id])
    resp = "ok"
    resp = "error" unless  @member.update_attributes(:facebook_id => params[:facebook_id])
    
    respond_to do |format|
        format.text {render :text => resp }
    end
  end
  
  def respond_fundation_admin
    adm = FundationAdmin.find(:first, :conditions => {:member_id =>params[:member_id], :fundation_id => params[:fundation_id]})
    adm.update_attributes(:active=>params[:active]) if adm and params[:active].to_s == "true"
    adm.destroy if adm and params[:active].to_s == "false"
    respond_to do |format|
      format.js {head :ok}
    end
  end
  
  def respond_provider_admin
    adm = ProviderAdmin.find(:first, :conditions => {:member_id =>params[:member_id], :provider_id => params[:provider_id]})
    adm.update_attributes(:active=>params[:active]) if adm and params[:active].to_s == "true"
    adm.destroy if adm and params[:active].to_s == "false"
    respond_to do |format|
      format.js {head :ok}
    end
  end  
  
  def respond_event_admin
    adm = EventAdmin.find(:first, :conditions => {:member_id =>params[:member_id], :event_id => params[:event_id]})
    adm.update_attributes(:active=>params[:active]) if adm and params[:active].to_s == "true"
    adm.destroy if adm and params[:active].to_s == "false"
    respond_to do |format|
      format.js {head :ok}
    end
  end  
  
end
