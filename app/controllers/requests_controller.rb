class RequestsController < ApplicationController
 
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "social"

 # before_action :request_params
  #
 # 
  
  def index
    @sent_requests = Request.where(:user_id => current_user.id)
    @received_requests = Request.where(:target_id => current_user.id)
    @pending = Request.where(:target_id => current_user.id,:status=>"PENDING").count
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @pending }
      format.json  { render :json => @sent_requests }
      format.json  { render :json => @received_requests }
    end
  end
 
  def accept(request_id,target_id)
    @request = Request.find(request_id)
    if @request.target_id = target_id
      @request.status = "ACCEPTED"
      @request.read_on
      @request.last_operation_on
      @request.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @requests }
      end
   
    else
       respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @requests }
      end
   
    end
  end
 
  def ignore(request_id,target_id)
    @requests = Request.where(:target_id => current_user.id)
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @requests }
    end
  end
  

  def admin
     @requests = Request.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @requests }
    end
  end
  
  def show
    @request = Request.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @request }
    end
  end

  def new
    @request = Request.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @requests }
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id

    if params[:request][:target_id].present?
      @user = User.find(params[:request][:target_id])
      @request.target_id = @user.id
      @request.relation ="FRIENDSHIP"
      @request.fullname = @user.firstname
      @request.target_email = @user.email
 
      @notify = Update.create(:sender_id=>current_user.id,:target_id=>@request.target_id,:reason=>'You have a request of connection')
    end
    
    respond_to do |format|
      if @request.save
        format.html  { redirect_to(request.referer,:notice => t('request sent')) }
        format.json  { render :json => @request, :status => :created, :location => @request }
      else
        format.html  { redirect_to(request.referer,:alert=> t('error while sending request')) }
        format.json  { render :json => @request.errors, :status => :unprocessable_entity }
      end
    end

  end
 
  def update
    @request = Request.find(params[:id])
    if params['accept'] == "accept"
      if current_user.id == @request.target_id
          @request.status = "ACCEPTED"
          @request.answered = true
          @request.save
          @friends1 = Friend.new(:user_id => current_user.id,:friend_id => @request.user_id,:relation =>"FRIEND")
          @friends1.save
          @friends2 = Friend.new(:user_id => @request.user_id,:friend_id => current_user.id,:relation =>"FRIEND")
          @friends2.save
          @notify = Update.create(:sender_id=>current_user.id,:target_id=>@request.user_id,:reason=>'your request has been accepted')
       end   
    elsif params['ignore'] == "ignore"
      if current_user.id == @request.target_id
          @request.status = "IGNORED"
          @request.answered = true
          @request.save
       end   
    end
    respond_to do |format|
      if @request.update_attributes(params[:request])
        
        format.html  { redirect_to(request.referer, :notice =>  t('request processed')) }
        format.json  { head :no_content }
      else
        format.html  { redirect_to(request.referer, :notice =>  t('error while processing')) }
        format.json  { render :json => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  @request = Request.find(params[:id])
  @request.destroy
    respond_to do |format|
       format.html  { redirect_to(request.referer, :notice =>  t('request destroyed')) }
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

  def request_params
    params.require(:request).permit(:target_id)
  end

end

