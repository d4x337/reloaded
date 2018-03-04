class BlockedUsersController < ApplicationController
  before_action :set_blocked_user, only: [:show, :edit, :update, :destroy]
  respond_to :html
  layout "search"
  def index
    @blocked_user = BlockedUser.where(:user_id=>current_user.id)
    respond_to do |format|
      format.html
      format.json  { render :json => @blocked_user }
    end
  end

  def new
    @blocked_user = BlockedUser.new
    respond_to do |format|
      format.html
      format.json  { render :json => @blocked_user }
    end
  end

  def edit
    @blocked_user = BlockedUser.find(params[:id])
  end

  def create
    @blocked_user = BlockedUser.new(params[:blocked_user])
    @blocked_user.blocked_at = DateTime.now
    @blocked_user.reason = "User Ban"
    respond_to do |format|
      if @blocked_user.save
        format.html  { redirect_to(request.referer,:notice => 'Person Blocked') }
        format.json  { render :json => @blocked_user,:status => :created, :location => @blocked_user }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @blocked_user.errors,:status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @blocked_user = BlockedUser.find(params[:id])
    respond_to do |format|
      if @blocked_user.update_attributes(params[:blocked_user])
        format.html  { redirect_to(:user_contacts_url, :notice => '.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @blocked_user.errors,:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @blocked_user = BlockedUser.find(params[:id])
    @blocked_user.destroy
    respond_to do |format|
       format.html { redirect_to request.referer,:notice => 'Unblocked' }
       format.json { head :no_content }
    end
  end
  
  private
  def set_blocked_user
    @status = BlockedUser.find(params[:id])
  end

  def blocked_user_params
    params[:blocked_user].permit(:user_id,:blocked_id,:reason,:blocked_at)
  end   

end
