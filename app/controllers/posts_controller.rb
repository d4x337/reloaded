class PostsController < ApplicationController

 before_filter :authenticate_user!
 #load_and_authorize_resource
 layout "blog"
 before_action :set_post, only: [:show, :edit, :update, :destroy,:crop]
 before_filter :authenticate_user!, :except => [:blog,:show,:author,:tags,:d4x337,:index,:idtag,:blog2]

 def index
   if current_user.blog.present?
     @blog = Blog.find(current_user.blog.id)
     @settings = BlogSettings.find(@blog.id)
     @posts = Post.order(:updated_at).reverse_order.paginate(:page => params[:page])
     respond_to do |format|
       format.html # index.html.erb
       format.js
       format.json  { render :json => @posts }
     end
   else
     respond_to do |format|
       format.html  { redirect_to('#',:notice => 'You do not have a blog.') }
     end
   end
 end

 def blog
      @blog = Blog.find(current_user.blog.id)
      @settings = BlogSettings.find(@blog.id)
      @posts = Post.where(:status => 'publish',:author=>current_user.id).order(:updated_at).reverse_order.paginate(:page => params[:page])
      @allposts = Post.where(:author=>current_user.id).order(:updated_at).reverse_order.paginate(:page => params[:page])
      @post = Post.new
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @posts }
        format.json  { render :json => @post }
        format.json  { render :json => @allposts }
        format.json  { render :json => @blog }
        format.json  { render :json => @quotes }
      end
  end

 def blog2
   @user = User.find_by_nickname('d4x337')
   @blog = Blog.find(1)
   @settings = BlogSettings.find(@blog.id)
   @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
   respond_to do |format|
     format.html # index.html.erb
     format.json  { render :json => @posts }
     format.json  { render :json => @blog }
     format.json  { render :json => @quotes }
   end
 end

 def idtag
   @user = User.find_by_nickname('d4x337')
   @blog = Blog.find(1)
   @settings = BlogSettings.find(@blog.id)
   @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
   respond_to do |format|
     format.html # index.html.erb
     format.json  { render :json => @posts }
     format.json  { render :json => @blog }
     format.json  { render :json => @quotes }
   end
 end

 def settings
   @blog = Blog.find(1)
   @blog_settings = BlogSettings.find(@blog.id)
   @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @posts }
      format.json  { render :json => @blog }
      format.json  { render :json => @quotes }
    end
 end
 
 def savesettings
    @blog = Blog.find(1)
    @blog_settings = BlogSettings.find(@blog.id)
    @blog_settings.border_color = 'lime'
    @blog.title = params[:title]
    @blog.motto = params[:motto]

    respond_to do |format|
      if @blog.save
        format.html  { redirect_to("/blog",:notice => 'Settings saved!') }
        format.json  { render :json => @blog, :status => :created, :location => @blog }
      else
        format.html  { redirect_to(request.referer)}
        format.json  { render :json => @blog.errors,:status => :unprocessable_entity }
      end
    end
 end
 
 def taggings
      @blog = Blog.find(1)
      @settings = BlogSettings.find(@blog.id)
      @user = @blog.author
      @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @posts }
        format.json  { render :json => @blog }
        format.json  { render :json => @quotes }
      end
  end
  
  def d4x337
      @blog = Blog.find(1)
      @settings = BlogSettings.find(@blog.id)
      @user = @blog.author
      @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @posts }
        format.json  { render :json => @blog }
        format.json  { render :json => @quotes }
        end

  end
 
  def author
      @blog = Blog.find(params[:id])
      @settings = BlogSettings.find(@blog.id)
      @user = @blog.author
      @posts = Post.where(:status => 'publish',:author=>1).order(:updated_at).reverse_order.paginate(:page => params[:page])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @posts }
        format.json  { render :json => @blog }
        format.json  { render :json => @quotes }
      end
  end
   

  def show
    @blog = Blog.find(1)
    @post = Post.find(params[:id])
    @tags = @post.post_tag;
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @posts }
      format.json  { render :json => @tags }
      format.json  { render :json => @comments }
      format.json  { render :json => @blog }
    end
  end

  def new
    @blog = Blog.find(1)
    @settings = BlogSettings.find(@blog.id)
    @post = Post.new
    @currentid = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @post }
    end
  end

  def edit
    @blog = Blog.find(1)
    @settings = BlogSettings.find(@blog.id)
    @post = Post.find(params[:id])
	  authorize! if can? :edit, @post
  end

  def newtag
    @blog = Blog.find(1)
    @settings = BlogSettings.find(@blog.id)
    @term = Term.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @term }
    end
  end
  
  def create
    @post = Post.new(params[:post])
    @post.author = current_user.id
    @tags_ids = params[:post][:tags].delete_if{ |x| x.empty?}
    @post.post_tag.destroy_all    
    @post.blog_id=current_user.blog.id
    respond_to do |format|
        if @post.save
         #  @tags_ids.each do |ids|
         #     @post.post_tag.create(:post_id => @post.id, :tag_id => ids)
         #  end
        format.html  { redirect_to('/blog',:notice => 'Post was successfully created.') }
        format.json  { render :json => @post, :status => :created, :location => @post }
      else
        format.html  { redirect_to('/blog')}
        format.json  { render :json => @post.errors,:status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    @tags_ids = params[:post][:tags].delete_if{ |x| x.empty?}
    @post.post_tag.delete_all    
    @tags_ids.each do |ids|
    @post.post_tag.create(:post_id => @post.id, :tag_id => ids)  
  end
        
    
    #@tags_ids.each do |x| 
    #  @post.post_tag.create(:tag_id => x,:post_id => @post.id )
    #end    
    #@post.post_tags.create(:id => params[:tags].delete_if{ |x| x.empty?})
    #@post.post_tag.create(:post_id =>:id,:tag_id => params[:tags][:id].delete_if{ |x| x.empty?})
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html  { redirect_to('/blog', :notice => 'Post successfully updated.' ) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @post.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
       format.html { redirect_to '/blog' }
       format.json { head :no_content }
    end
  end
  
  def tags_ids
    @post = Post.find(params[:id])
    @post.post_tags.map(&:tag_id)
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
       params.require(:post).permit(:allimage, :tags)
    end
  
end
