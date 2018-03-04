class MiniPostLikingsController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource
  layout :custom_layout
   
  def create 
    @mini_post_likings = MiniPostLiking.new(params[:mini_post_liking])
    @user = current_user
    @mini_post_likings.user_id = current_user.id;

    respond_to do |format|
      if @mini_post_likings.save
        format.html  { redirect_to(request.referer,:notice => 'Like added') }
        format.json  { render :json => @mini_post_likings, :status => :created, :location => @mini_post_likings }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @mini_post_likings.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def index
    @mini_post_likings = MiniPostLiking.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @mini_post_likings }
    end
  end

  def show
    @mini_post_liking = MiniPostLiking.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mini_post_liking }
    end
  end

  def new
    @mini_post_likings = MiniPostLiking.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mini_post_likings }
    end
  end

  def edit
    @mini_post_likings = MiniPostLiking.find(params[:id])
  end

    
  def update
    @mini_post_likings = MiniPostLiking.find(params[:id])
     if params[:like] == "like"
      @mini_post_likings.liking = true
    elsif params[:dislike] == "dislike"
      @mini_post_likings.liking = false
    end  
  
    respond_to do |format|
      if @mini_post_likings.update_attributes(params[:mini_post_liking])
         format.html  { redirect_to(request.referer,:notice => 'Like/Dislike updated') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @mini_post_likings.errors,:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mini_post_likings = MiniPostLiking.find(params[:id])
    @mini_post_likings.destroy
    respond_to do |format|
       format.html  { redirect_to(request.referer,:notice => 'Like removed') }
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

