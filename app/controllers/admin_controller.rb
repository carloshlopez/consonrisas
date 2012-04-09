require 'csv'
class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_member!, :except => [:members_to_csv]

  def index
    flash[:notice] = ""
    @models = {}
    @tables = {}    
    if current_member.try(:admin?)
      #
      # Dir.foreach("#{RAILS_ROOT}/app/models") do |model_path|
      # unless model_path.split(".")[0].nil?
      # model_name= model_path.split(".")[0].capitalize
      # model= Object.const_get(model_name)
      # @models[model_name] = {:columns=>model.column_names}
      # end
      # end

      # For development all models have to be queried to be initialized, not in production
      if(Rails.env.development?) then
        Alert.all
        Comment.all
        ContactInformation.all
        Event.all
        EventAdmin.all
        Facilitator.all
        Feedback.all
        Fundation.all
        FundationAdmin.all
        Member.all
        Photo.all
        Population.all
        Provider.all
        ProviderAdmin.all
        Role.all
        Show.all
        Authentication.all
      end
      
      ActiveRecord::Base.send(:descendants).each do |c|
        begin
          model= Object.const_get(c.name)
          @models[c.name] = {:columns=>model.column_names}
          @tables[c.name] = c.name.tableize.singularize
        rescue Exception=>e
            puts "Error #{e}"
        end
      end
    end
  end

  def get_table_data
    if current_member.try(:admin?)
      model = Object.const_get(params[:table_name].camelize)
      @table_data = { :results => model.all }
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml { render :xml => @table_data }
        format.json { render :json => @table_data }
      end
    end
  end
  
  # PUT /admin/db/:table_name
  def update_table_data
    if current_member.try(:admin?)
      id = params[:id]
      table_name = params[:table_name]
      column_name = params[:column_name]
      value = params[:value]
      
      model = Object.const_get(table_name.camelize)
      model.find(id).update_attributes({column_name=>value})
    end
  end
  
  def create_table_data
    if current_member.try(:admin?)
      table_name = params[:table_name]
      values = Hash.new
      
      model = Object.const_get(table_name.camelize)
      @new_model = model.new(params[table_name.to_sym])
      if @new_model.save
        @success = "Ok"
      else
        @success = "Error"
      end
    end
  end
  
  def delete_table_data
    if current_member.try(:admin?)
      id = params[:id]
      table_name = params[:table_name]
      
      model = Object.const_get(table_name.camelize)
      model.find(id).destroy
    end
    respond_to do |format|
      format.js {head:ok}
    end
  end
  
  def members_to_csv 
    @users = Member.find(:all) 
    csv_string = CSV.generate do |csv| 
      # header row 
      csv << ["email", "name"] 
   
      # data rows 
      @users.each do |user| 
        name = 'Sin Nombre'
        name = user.facilitator.name if user.facilitator
        csv << [user.email, name] 
      end 
    end 
    send_data csv_string, 
              :type => 'text/csv; charset=iso-8859-1; header=present', 
              :disposition => "attachment; filename=users.csv" 
  end  
  
  def dj_all
    if current_member.try(:admin?)    
      @jobs = Delayed::Job.all

      respond_to do |format|
        format.html # index.html.erb
      end  
    end
  end
  
  def dj_show
    if current_member.try(:admin?)    
      begin
        @job = Delayed::Job.find(params[:id])
      rescue
        redirect_to [:admin_dj_all], :notice => 'That specific job has finished processing'
      end
    end
  end

  def dj_destroy
    if current_member.try(:admin?)
      @job = Delayed::Job.find(params[:id])
      @job.destroy
      
      respond_to do |format|
        format.html {redirect_to(dj_all_path, :notice => 'Job destroyed')}
      end
    end
  end  
  
  
  
end
