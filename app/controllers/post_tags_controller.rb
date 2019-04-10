class PostTagsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:home]
  load_and_authorize_resource
  
  
  def index
    #@things = current_user.things
    @post_tags = PostTag.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @post_tags }
    end
  end



  def show
    @post_tags = PostTag.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @post_tags }
    end
  end

  def new
    @post_tags = PostTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @post_tags }
    end
  end

  def edit
    @post_tags = PostTag.find(params[:id])
  end

  def create
    @post_tags = PostTag.new(post_tags_params)
    
  
    respond_to do |format|
      if @post_tags.save
        format.html  { redirect_to(post_tags_url,
                      :notice => 'Post-Tag was successfully created.') }
        format.json  { render :json => @post_tags,
                      :status => :created, :location => @post_tags }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @post_tags.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @post_tags = PostTag.find(params[:id])
  
    respond_to do |format|
      if @post_tags.update_attributes(params[:post_tag])
        format.html  { redirect_to(post_tags_url, :notice => 'Term Relationship was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @post_tags.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post_tags = PostTag.find(params[:id])
    @post_tags.destroy

    respond_to do |format|
       format.html { redirect_to post_tags_url }
       format.json { head :no_content }
    end
  end

  def post_tags_params
    params.fetch(:post_tag,{}).permit(:mini_post_id,:tag_id)
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

