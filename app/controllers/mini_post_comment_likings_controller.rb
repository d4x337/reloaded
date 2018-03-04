class MiniPostCommentLikingsController < ApplicationController
  
  before_filter :authenticate_user!
  layout :custom_layout

  
  def create
    @mini_post_comment_liking = MiniPostCommentLiking.new(params[:mini_post_comment_liking])
    @user = current_user
    @mini_post_comment_liking.user_id = @user.id;
   
    if params[:feed] == "like"
      @mini_post_comment_liking.liking = true
    elsif params[:feed] == "dislike"
      @mini_post_comment_liking.liking = false
    end  
     
    respond_to do |format|
      if @mini_post_comment_liking.save
        format.html  { redirect_to(request.referer,:notice => 'Feed added') }
        format.json  { render :json => @mini_post_comment_liking, :status => :created, :location => @mini_post_likings }
      else
        format.html  { redirect_to(request.referer)}
        format.json  { render :json => @mini_post_comment_liking.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @mini_post_comment_liking = MiniPostCommentLiking.find(params[:mini_post_comment_liking][:mini_post_comment_liking_id])
    @mini_post_comment_liking.destroy
     respond_to do |format|
       format.html  { redirect_to(request.referer,:notice => 'Feed deleted') }
       format.json { head :no_content }
    end
  end
  
  def index
    #@things = current_user.things
    @mini_post_comment_liking = MiniPostCommentLiking.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @mini_post_comment_liking }
    end
  end

  def show
    @mini_post_comment_liking = MiniPostCommentLiking.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mini_post_comment_liking }
    end
  end

  def new
    @mini_post_comment_likings = MiniPostCommentLiking.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mini_post_comment_likings }
    end
  end

  def edit
    @mini_post_comment_likings = MiniPostCommentLiking.find(params[:id])
  end

    
  def update
    @mini_post_comment_likings = MiniPostCommentLiking.find(params[:id])
     if params[:like] == "like"
      @mini_post_comment_likings.liking = true
    elsif params[:dislike] == "dislike"
      @mini_post_comment_likings.liking = false
    end  
  
    respond_to do |format|
      if @mini_post_comment_likings.update_attributes(params[:mini_post_comment_liking])
         format.html  { redirect_to(request.referer,:notice => 'Feed updated') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @mini_post_comment_likings.errors,:status => :unprocessable_entity }
      end
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



