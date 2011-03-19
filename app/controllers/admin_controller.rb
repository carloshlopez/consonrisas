class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_member!

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
        Role.all
        Show.all
      end
      
      ActiveRecord::Base.send(:subclasses).each do |c|
        model= Object.const_get(c.name)
        @models[c.name] = {:columns=>model.column_names}
        @tables[c.name] = c.name.tableize.singularize
      end
    end
  end

  def get_table_data
    if current_member.try(:admin?)
      model = Object.const_get(params[:table_name].camelize)
      @table_data = { :results => model.find(:all) }
    
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
end
