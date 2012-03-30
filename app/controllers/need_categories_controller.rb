class NeedCategoriesController < ApplicationController
  # GET /need_categories
  # GET /need_categories.xml
  def index
    @need_categories = NeedCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @need_categories }
    end
  end

  # GET /need_categories/1
  # GET /need_categories/1.xml
  def show
    @need_category = NeedCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @need_category }
    end
  end

  # GET /need_categories/new
  # GET /need_categories/new.xml
  def new
    @need_category = NeedCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @need_category }
    end
  end

  # GET /need_categories/1/edit
  def edit
    @need_category = NeedCategory.find(params[:id])
  end

  # POST /need_categories
  # POST /need_categories.xml
  def create
    @need_category = NeedCategory.new(params[:need_category])

    respond_to do |format|
      if @need_category.save
        format.html { redirect_to(@need_category, :notice => 'Need category was successfully created.') }
        format.xml  { render :xml => @need_category, :status => :created, :location => @need_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @need_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /need_categories/1
  # PUT /need_categories/1.xml
  def update
    @need_category = NeedCategory.find(params[:id])

    respond_to do |format|
      if @need_category.update_attributes(params[:need_category])
        format.html { redirect_to(@need_category, :notice => 'Need category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @need_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /need_categories/1
  # DELETE /need_categories/1.xml
  def destroy
    @need_category = NeedCategory.find(params[:id])
    @need_category.destroy

    respond_to do |format|
      format.html { redirect_to(need_categories_url) }
      format.xml  { head :ok }
    end
  end
end
