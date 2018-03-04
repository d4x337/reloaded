class MiniMiniPostTagsController < ApplicationController
 #before_filter :authenticate_user!, :except => [:home]
  #load_and_authorize_resource
  layout :custom_layout
  
  def index
    #@things = current_user.things
    @mini_post_tags = MiniPostTag.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @mini_post_tags }
    end
  end



  def show
    @mini_post_tags = MiniPostTag.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mini_post_tags }
    end
  end

  def new
    @mini_post_tags = MiniPostTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mini_post_tags }
    end
  end

  def edit
    @mini_post_tags = MiniPostTag.find(params[:id])
  end

  def create
    @mini_post_tags = MiniPostTag.new(params[:mini_post_tag])
    respond_to do |format|
      if @mini_post_tags.save
        format.html  { redirect_to(mini_post_tags_url,:notice => 'Post-Tag was successfully created.') }
        format.json  { render :json => @mini_post_tags,:status => :created, :location => @mini_post_tags }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @mini_post_tags.errors,:status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @mini_post_tags = MiniPostTag.find(params[:id])
  
    respond_to do |format|
      if @mini_post_tags.update_attributes(params[:mini_post_tag])
        format.html  { redirect_to(mini_post_tags_url, :notice => 'Term Relationship was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @mini_post_tags.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mini_post_tags = MiniPostTag.find(params[:id])
    @mini_post_tags.destroy

    respond_to do |format|
       format.html { redirect_to mini_post_tags_url }
       format.json { head :no_content }
    end
  end
  
  private
  def custom_layout
       if current_user.role? :admin  
        "dashboard"    
       else current_user.role? :user
        "social"
       end 
   end
end

