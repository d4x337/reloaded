class UpdatesController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!
  layout "social"

  def index
     @count_new = Update.where(:target_id => current_user.id,:read => false).count
     @updates   = Update.where(:target_id => current_user.id).order(:read)
     @nowread   = Update.where(:target_id => current_user.id,:read => false)
     @nowread.each do |update|
       update.read = true
       update.save!
     end
     respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json  { render :json => @updates }
    end
  end
  
  def admin
     #@things = current_user.things
     @updates = Update.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @updates }
    end
  end
  
  def show
    @update = Update.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @update }
    end
  end

  def new
    @update = Update.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @updates }
    end
  end

  def edit
    @update = Update.find(params[:id])
  end

  def create
    @update = Update.new(params[:update])
      respond_to do |format|
      if @update.save
        format.html  { redirect_to(request.referer,
                  :notice => 'update successfully created') }
        format.json  { render :json => @update, :status => :created, :location => @update }
 
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
     @update = Update.find(params[:id])
     
     #@update.read = params['update_read']
     if params['update_read']= '0'
       @update.read = true
      else
        @update.read = false
      end
      @update.read_at = DateTime.now
     respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html  { redirect_to(request.referer, :notice =>  'notification has been read ') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  def updateOLD
    @update = Update.find(params[:id])
    
    if not params[:update_read].blank?
      if params[:update_read] = '1'
       @update.read = true
      elsif  params[:update_read] = '0'
        @update.read = false
      end
      respond_to do |format|
        if @update.update_attributes(params[:update])
          format.html  { redirect_to(request.referer, :notice =>  'Updates has been read') }
          format.json  { head :no_content }
        else
          format.html  { redirect_to(request.referer, :notice =>  'update what?') }
          format.json  { head :no_content }
        end
      end
    end
  end

  def destroy
  @update = Update.find(params[:id])
  @update.destroy
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
