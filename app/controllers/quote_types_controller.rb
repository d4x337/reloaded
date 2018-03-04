class QuoteTypesController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  load_and_authorize_resource
  layout 'dashboard'

  def admin
     @quote_types = QuoteType.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quote_types }
    end
  end

  def index
     @quote_types = QuoteType.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quote_types }
    end
  end

 def list
     #@things = current_user.things
     @quote_types = QuoteType.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quote_types }
    end
  end
  
  def show
    @quote_types = QuoteType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @quote_types }
    end
  end

  def new
    @quote_type = QuoteType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @quote_types }
    end
  end

  def edit
    @quote_type = QuoteType.find(params[:id])
  end

  def create
    @quote_type = QuoteType.new(params[:quote_type])
      respond_to do |format|
      if @quote_type.save
        format.html  { redirect_to(@quote_type,
                  :notice => 'quote_type was successfully created.') }
        format.json  { render :json => @quote_type, :status => :created, :location => @quote_type }
 
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @quote_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @quote_type = QuoteType.find(params[:id])
    respond_to do |format|
    if @quote_type.update_attributes(params[:quote_type])
      format.html  { redirect_to(request.referer, :notice => 'quote_type was successfully updated.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @quote_type.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
  @quote_type = QuoteType.find(params[:id])
  @quote_type.destroy
    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end
  
   private
  def custom_layout
       if current_user.role? :admin  
        "dashboard"    
       else current_user.role? :user
        "welcome"
       end 
   end
end

