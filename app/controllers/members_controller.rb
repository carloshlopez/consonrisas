class MembersController < ApplicationController
  before_filter :authenticate_member!, :except => :check_email
  skip_before_filter  :verify_authenticity_token, :only => :check_email


  # GET /members/1
  # GET /members/1.xml
  def show
    @total_needs = ProjectNeed.all.count
    @no_cat_needs = ProjectNeed.where("need_category_id IS NULL")
    @need_categories = NeedCategory.all
    @news_feed = GlobalAlert.all(:order=>"id DESC", :limit => 15)
    @member = Member.find(params[:id])
    @fac = @member.facilitator
    @invites = @member.my_invites
    @msgs = @member.my_msgs
    @num_new_invites = @member.num_new_invites
    @num_new_msgs = @member.num_new_msgs
    @show_welcome = false
    @show_facilitator = false
    @show_fundation = false
    @show_provider = false   
    @facilitator_step = 0;
    @fundation_step = 0;
    @provider_step = 0;        
    @num_steps = 0;
    if session[:isFacilitator] and !@member.facilitator.city
      @show_welcome = true
      @show_facilitator = true
#      session[:isFacilitator] = nil
      @facilitator_step = 1;
      @num_steps = @num_steps + 1
    end
    if session[:isFundation] and session[:fundation]
      @fundation = Fundation.find(session[:fundation])
#      session[:fundation] = nil
#      session[:isFundation] = nil
      @show_welcome = true
      @show_fundation = true
      @fundation_step = @facilitator_step + 1
      @num_steps = @num_steps + 1
    end
    if session[:isProvider]
      @provider = Provider.find(session[:provider])
#      session[:provider] = nil
#      session[:isProvider] = nil
      @show_welcome = true
      @show_provider = true
      @provider_step = @fundation_step + 1
      @num_steps = @num_steps + 1
    end
    if member_signed_in? and current_member.id == @member.id
      @contact_informations = @member.contact_informations
    else
      respond_to do |format|
        format.json do
          if @fundation
            render :json=>{:member=>@member, :fundation=>@fundation}
          else
            render :json=>{:member=>@member}
          end
        end
        format.html {redirect_to facilitator_path(@member.facilitator)}
      end
    end
  end

  def cleanInitialSession
      session[:provider] = nil
      session[:isProvider] = nil
      session[:fundation] = nil
      session[:isFundation] = nil
      session[:isFacilitator] = nil
    respond_to do |format|
      format.json { render :json => {:resp => "ok"} }
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
    puts "Is it here!?!?!"
    @member = Member.new(params[:member])
    respond_to do |format|
      if @member.save 
        format.html { redirect_to(@member, :notice => 'Member was successfully created.') }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
        format.json {render :json => @member, :status => :created, :location => @member }
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
    resp = {"resp" => "ok"}
    begin
      @alert = Alert.find(params[:alert_id])
      @alert.destroy
    rescue => e
      resp = {"resp" => "error", "message" => e.message}
    end
    respond_to do |format|
      format.json  { render :json=> resp }      
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
  
  def change_pic
    @member = Member.find(params[:member_id])
    @fac = @member.facilitator
    if @fac.update_attributes(params[:facilitator])    
      render :json => { :pic_path_big => @fac.pic.url(:profile).to_s, :pic_path => @fac.pic.url(:thumb).to_s , :name => @fac.pic.instance.attributes["pic_file_name"] }, :content_type => 'text/html'    
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end 
  
  
  def get_fundations
    @member = Member.find(params[:id])
    @fundation_admins = @member.fundation_admins
    respond_to do |format|
      format.json {render :json=>@fundation_admins}
    end
  end
  
  def check_email
    @member = Member.find_by_email(params[:email])
    respond_to do |format|
      format.json {render :json=>@member}
    end
  end
  
  def edit_settings
    @member = current_member
  end
  
  def my_invites
    @member = Member.find(params[:member_id])
    @invites = current_member.alerts.where("alert_type=1").order("created_at DESC")
  end
  
  def my_msgs
    @msgs = current_member.alerts.where("alert_type = 2").order("created_at DESC")
    @member = Member.find(params[:member_id])
  end

  def accept_invite
    event = Event.find(params[:event_id])
    role_id = params[:role_id].to_i
    resp = {:resp=>"error", :msg=>"no se encontro el rol #{role_id} dentro de los asistentes del evento #{event.id}"}
    provider_event = event.event_providers.detect{|i| i.provider_id == role_id}
    unless provider_event.nil?
      provider_event.pending_invitation = false
      provider_event.is_going = true
      provider_event.save
      resp = {:resp=>"accepted", :role=>"provider"}
    end
    
    fundation_event = event.event_fundations.detect{|i| i.fundation_id == role_id}
    unless fundation_event.nil?
      fundation_event.pending_invitation = false
      fundation_event.is_going = true
      fundation_event.save
      resp = {:resp=>"accepted", :role=>"fundation"}
    end
    
    facilitator_event = event.event_facilitators.detect{|i| i.facilitator_id == role_id}
    unless facilitator_event.nil?
      facilitator_event.pending_invitation = false
      facilitator_event.is_going = true
      facilitator_event.save
      resp = {:resp=>"accepted", :role=>"facilitator"}
    end    

    respond_to do |format|
      format.json  { render :json=> resp }
    end   
  end  

  def reject_invite
    event = Event.find(params[:event_id])
    role_id = params[:role_id].to_i
    resp = {:resp=>"error", :msg=>"no se encontro el rol #{role_id} dentro de los asistentes del evento #{event.id}"}
    
    provider_event = event.event_providers.detect{|i| i.provider_id == role_id}
    unless provider_event.nil?
      provider_event.pending_invitation = false
      provider_event.is_going = false
      provider_event.save
      resp = {:resp=>"accepted", :role=>"provider"}
    end
    
    fundation_event = event.event_fundations.detect{|i| i.fundation_id == role_id}
    unless fundation_event.nil?
      fundation_event.pending_invitation = false
      fundation_event.is_going = false
      fundation_event.save
      resp = {:resp=>"accepted", :role=>"fundation"}
    end

    facilitator_event = event.event_facilitators.detect{|i| i.facilitator_id == role_id}
    unless facilitator_event.nil?
      facilitator_event.pending_invitation = false
      facilitator_event.is_going = false
      facilitator_event.save
      resp = {:resp=>"accepted", :role=>"facilitator"}
    end    

    respond_to do |format|
      format.json  { render :json=> resp }
    end   
  end

  def seen_invites
    Alert.update_all( {:seen => true}, {:member_id => params[:member_id], :alert_type=> 1} )
    resp = {:resp=>"ok"}
    respond_to do |format|
      format.json  { render :json=> resp }
    end       
  end

  def seen_msgs
    Alert.update_all( {:seen => true}, {:member_id => params[:member_id], :alert_type=> 2} )
    resp = {:resp=>"ok"}    
    respond_to do |format|
      format.json  { render :json=> resp }
    end       
  end
  
end
