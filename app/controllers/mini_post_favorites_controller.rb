class MiniPostFavoritesController < ApplicationController

  #before_filter :authenticate_user!
  #load_and_authorize_resource
  layout :custom_layout
   
  def create 
    @mini_post_favorites = MiniPostFavorite.new(params[:mini_post_favorite])
    @user = current_user
    @mini_post_favorites.user_id = current_user.id;
   
    
    respond_to do |format|
      if @mini_post_favorites.save
        format.html  { redirect_to(request.referer,:notice => 'Favorite added') }
        format.json  { render :json => @mini_post_favorites, :status => :created, :location => @mini_post_favorites }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @mini_post_favorites.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def index
    #@things = current_user.things
    @mini_post_favorites = MiniPostFavorite.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @mini_post_favorites }
    end
  end

  def show
    @mini_post_favorite = MiniPostFavorite.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mini_post_favorite }
    end
  end

  def new
    @mini_post_favorites = MiniPostFavorite.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mini_post_favorites }
    end
  end

  def edit
    @mini_post_favorites = MiniPostFavorite.find(params[:id])
  end

    
  def update
    @mini_post_favorites = MiniPostFavorite.find(params[:id])
     if params[:like] == "like"
      @mini_post_favorites.favorite = true
    elsif params[:dislike] == "dislike"
      @mini_post_favorites.favorite = false
    end  
  
    respond_to do |format|
      if @mini_post_favorites.update_attributes(params[:mini_post_favorite])
         format.html  { redirect_to(request.referer,:notice => 'Like/Dislike updated') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @mini_post_favorites.errors,:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mini_post_favorites = MiniPostFavorite.find(params[:id])
    @mini_post_favorites.destroy
    respond_to do |format|
       format.html  { redirect_to(request.referer,:notice => 'Favorite deleted') }
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

