class BlogSettingsController < ApplicationController
  

  def index
    @blog_settings = current_user.blog.settings
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @blog_settings }
    end
  end

  def show
    @blog_settings = BlogSettings.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @blog_settings }
    end
  end

  def new
    @blog_settings = BlogSettings.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @blog_settings }
    end
  end

  def edit
    @blog_settings = BlogSettings.find(params[:id])
  end

  def create
    @blog_settings = BlogSettings.new(blog_settings_params)
    respond_to do |format|
      if @blog_settings.save
        format.html  { redirect_to(post_tags_url,:notice => 'Settings updated.') }
        format.json  { render :json => @blog_settings,:status => :created, :location => @blog_settings }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @blog_settings.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @blog_settings = BlogSettings.find(params[:id])
    respond_to do |format|
      if @blog_settings.update_attributes(blog_settings_params)
        format.html  { redirect_to(post_tags_url, :notice => 'Settings successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @blog_settings.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog_settings = BlogSettings.find(params[:id])
    @blog_settings.destroy

    respond_to do |format|
       format.html { redirect_to post_tags_url }
       format.json { head :no_content }
    end
  end

  protected
  def blog_settings_params
    params.fetch(:blog_settings,{}).permit(
        :blog_id,
        :border_color,
        :text_color,
        :background_color,
        :allow_comments)
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

