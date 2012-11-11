class FundationsController < ApplicationController
  before_filter :authenticate_member!, :except => [:index]
  # GET /fundations
  # GET /fundations.xml
  def index
#    @fundations = Fundation.all
    @fundations = Fundation.order("name").page(params[:page]).per(8)
    @num_fundations = Fundation.count
  end

  # GET /fundations/1
  # GET /fundations/1.xml
  def show
    @fundation = Fundation.find(params[:id])
    @meta_name = "Proyecto Social"
    @meta_name = @fundation.name if @fundation.name
    @meta_desc = @meta_name
    @meta_desc = @fundation.description[0, 350] if @fundation.description
    if @fundation.pic(:thumb) and @fundation.pic(:profile).include? "s3"
      @meta_img = @fundation.pic(:profile)
    else
      @meta_img = "http://www.conectandosonrisas.org" << @fundation.pic.url(:profile)
    end
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
    respond_to do |format|
      if @fundation.save

        FundationAdmin.create(:member_id =>params[:member_id], :fundation_id => @fundation.id, :active=>true)
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
    params[:fundation][:population_ids] ||= []     
    @fundation = Fundation.find(params[:id])

    respond_to do |format|
      if @fundation.update_attributes(params[:fundation])
        format.html { redirect_to(@fundation, :notice => 'Fundation was successfully updated.') }
        format.xml  { head :ok }
        format.json { render :json => {:resp => "ok"} }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fundation.errors, :status => :unprocessable_entity }
        format.json { render :json => {:resp => "error"} }        
      end
    end
  end

  # DELETE /fundations/1
  # DELETE /fundations/1.xml
  def destroy
    @fundation = Fundation.find(params[:id])
    @fundation.destroy
    resp ={"resp" => "ok"}

    respond_to do |format|
      format.html { redirect_to(fundations_url) }
      format.xml  { head :ok }
      format.json {render :json=>resp}
    end
  end
  
  def add_follower
    fundation = Fundation.find(params[:fundation_id])
    facilitator = Facilitator.find(params[:facilitator_id])
    fundation.facilitators.push(facilitator)
    respond_to do |format|
      format.json {render :json=> 'ok'}
    end
  end
  
  def remove_follower
    fundation = Fundation.find(params[:fundation_id])
    facilitator = Facilitator.find(params[:facilitator_id])
    fundation.facilitators.delete(facilitator)
    respond_to do |format|
      format.json {render :json=> 'ok'}
    end
  end
  
  def ask_admin
    fundation = Fundation.find(params[:fundation_id])
    fundation.ask_admin params[:member_id] if params[:member_id].to_s != "-1" and params[:member_id].to_s != ""
    fundation.ask_admin_by_mail params[:mail] if params[:mail].to_s != "mail" and params[:mail].to_s != ""
    respond_to do |format|
      format.js {head :ok}
    end
  end
  
  def send_msg_to_admins
    resp = {:message=> "ok"}
    begin
      fundation = Fundation.find(params[:fundation_id])
      member_from = Member.find(params[:member_from])
      fundation.send_msg_to_admins(member_from, params[:msg])
    rescue => e 
      puts "Error on fundations send_msg_to_admins: #{e.inspect}"
      resp = {:message => e.message}
    end
    respond_to do |format|
      format.json {render :json=>resp}
    end
  end  
  
 
  def change_pic
    if params[:fundation_id]
      @fund = Fundation.find(params[:fundation_id])
    else
      @fund = Fundation.find(params[:es_fundation_id])
    end
    if @fund.update_attributes(params[:fundation])    
      render :json => { :pic_path_big => @fund.pic.url(:profile).to_s, :pic_path => @fund.pic.url(:thumb).to_s , :name => @fund.pic.instance.attributes["pic_file_name"] }, :content_type => 'text/html'    
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end  
  
  def needs
    @fundation = Fundation.find(params[:fundation_id])
    respond_to do |format|
      format.html {render :layout=> false}
      format.json {render :json=>@fundation}
    end
  end
  
  
end
