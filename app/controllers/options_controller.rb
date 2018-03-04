class OptionsController < ApplicationController

 # load_and_authorize_resource
  before_filter :authenticate_user!
  layout 'dashboard'
 
  def index
    @options = Option.all
     respond_to do |format|
      format.html
      format.json  { render :json => @options }
    end
  end
 
  def registrations_mode
    if current_user.role? :admin
      if params["INVITED_ONLY"].blank?
        render :json => [false]
        return
      else
        @option = Option.find_by_name('REGISTRATIONS_STATUS')
        puts "PARAMS "+params["INVITED_ONLY"]
        
        if params["INVITED_ONLY"] == "true"
          @option.value = "INVITED_ONLY"
          @option.save!
          puts "CHANGED_TO INVITED_ONLY"
          render :json => [true]
        else
          @option.value = "OPEN"
          @option.save!
          puts "CHANGED_TO OPEN"
          render :json => [true]
        end
      end
    else
         render :json => [false]
    end
  end

  def show
    @options  = Option.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @options }
    end
  end

  def new
    @option  = Option.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @options }
    end
  end

  def edit
    @option  = Option.find(params[:id])
  end

  def create
    @option  = Option.new(params[:option])
      respond_to do |format|
      if @option.save
        format.html  { redirect_to(options_url,
                  :notice => 'Option created successfully.') }
        format.json  { render :json => @option, :status => :created, :location => @option }
 
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @option  = Option.find(params[:id])
    respond_to do |format|
    if @option.update_attributes(params[:option])
      format.html  { redirect_to(options_url, :notice => 'Option updated successfully.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @option.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
  @option  = Option.find(params[:id])
  @option.destroy
    respond_to do |format|
       format.html { redirect_to options_url, :notice => 'Option deleted successfully.' }
       format.json { head :no_content }
    end
  end

end
