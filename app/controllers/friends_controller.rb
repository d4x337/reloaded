class FriendsController < ApplicationController
 
  before_filter :authenticate_user!
  layout "search"
 
  def index
     @friends = Friend.where(:user_id => current_user.id)
     if current_user.friends.count > 0
        @users   = User.where(['id != ? and id in (?)',current_user.id.to_s,current_user.friends.map(&:friend_id)])
     else
        @users   = User.where('id != ?', current_user.id.to_s)
     end
     @friend  = Friend.new
    
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @friends }
      format.json  { render :json => @users }
    end
  end
  
  def personal
     @friends = Friend.where(:user_id => current_user.id)
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @friends }
    end
  end
  
  def list
    @friends = Friend.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @friends }
    end
  end
  
  def show
    @friend = Friend.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @friend }
    end
  end

  def new
    @friend = Friend.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @friends }
    end
  end

  def edit
    @friend = Friend.find(params[:id])
  end

  def create
    @friends = Friend.new(:user_id => current_user.id,:friend_id => params[:friend][:friend_id],:friendship=>params[:friend][:friendship])
    @otherfriend = Friend.new(:user_id => params[:friend][:friend_id],:friend_id => current_user.id,:friendship=>params[:friend][:friendship])
      respond_to do |format|
      if @friends.save
        @otherfriend.save
        @notify = Update.create(:sender_id=>current_user.id,:target_id=>params[:friend][:friend_id],:reason=>t('you have a new connection'))
        format.html  { redirect_to('/friends', :notice => t('you have a new connection')) }
        format.json  { render :json => @friends, :status => :created, :location => @friends }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @friends.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy
    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end

end

