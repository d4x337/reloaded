class MiniPostsController < ApplicationController

  #rao;s load_and_authorize_resource
  before_filter :authenticate_user!

  respond_to :html, :js
  def index
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @wert = last
    @mini_posts = MiniPost.feed(last,current_user.id)
  end

  def liking
    mp_id  = params['mp_id']
    mpl_id = params['mpl_id']
    act = params['act']
    if act =='1'
      respond_to do |format|
        @mini_post_liking = MiniPostLiking.create(:user_id=>current_user.id,:mini_post_id=>mp_id,:liking=>true)
        @return = @mini_post_liking.id if @mini_post_liking.save
        @counter = MiniPostLiking.where(:mini_post_id=>mp_id,:liking=>true,:deleted=>false).count
        format.html { render :json => "OKL+"+@return.to_s+":"+@counter.to_s }
      end
    elsif act == '0'
      begin
        @mini_post_likings = MiniPostLiking.find(mpl_id)
        @mini_post_likings.destroy
      rescue ActiveRecord::RecordNotFound

      end
      @counter = MiniPostLiking.where(:mini_post_id=>mp_id,:liking=>true,:deleted=>false).count
      respond_to do |format|
        @return = 0
        format.html { render :json => "OKL-"+@counter.to_s }
      end
    end
  end

  def favoriting
    mp_id  = params['mp_id']
    mpl_id = params['mpf_id']
    act = params['act']
    if act =='1'
      respond_to do |format|
        @mini_post_favorite = MiniPostFavorite.create(:user_id=>current_user.id,:mini_post_id=>mp_id,:favorite=>true)
        @return = @mini_post_favorite.id if @mini_post_favorite.save
        @counter = MiniPostFavorite.where(:mini_post_id=>mp_id,:favorite=>true,:deleted=>false).count
        format.html { render :json => "OKF+"+@return.to_s+":"+@counter.to_s }
      end
    elsif act == '0'
      begin
        @mini_post_favorite = MiniPostFavorite.find(mpl_id)
        @mini_post_favorite.destroy

      rescue ActiveRecord::RecordNotFound

      end
      @scounter = MiniPostFavorite.where(:mini_post_id=>mp_id,:favorite=>true,:deleted=>false).count
      respond_to do |format|
        @return = 0
        format.html { render :json => "OKF-"+@scounter.to_s }
      end
    end
  end

  def likingOLD
      mp_id  = params['mp_id']
      mpl_id = params['mpl_id']
      act = params['act']
        puts act
      if act == '1'
       respond_to do |format|

         @result = MiniPostLiking.create(:user_id=>current_user.id,:mini_post_id=>mp_id,:liking=>true)
         if @result.save
           @return = @result.id
           format.html { render :json => @return }
         else
           @return = -1
           format.html { render :json => @return }
         end
       end  
     elsif act == '0'
       begin
         @mini_post_likings = MiniPostLiking.find(mpl_id)
         #@mini_post_likings.deleted=true
         #@mini_post_likings.liking=false
         #@mini_post_likings.updated_at=DateTime.now
         #@result =@mini_post_likings.save

         @result = @mini_post_likings.destroy #if @mini_post_likings
       end
       respond_to do |format|
         @return = 0
         format.html { render :json => @return }
       end
     end
  end
  
  def disliking
    mp_id  = params['mp_id']
    mpl_id = params['mpl_id']
    act = params['act']
    puts act
    if act == '1'
     respond_to do |format|

       @result = MiniPostLiking.create(:user_id=>current_user.id,:mini_post_id=>mp_id,:liking=>false)
       if @result.save
         @return = @result.id
         format.html { render :json => @return }
       else
         @return = -1
         format.html { render :json => @return }
       end
     end
   elsif act == '0'
     begin
       @mini_post_likings = MiniPostLiking.find(mpl_id)
       @result = @mini_post_likings.destroy
     end
     respond_to do |format|
       @return = 0
       format.html { render :json => @return }
     end
    end
  end



   def favoritingOLD
      mp_id  = params['mp_id']
      mpl_id = params['mpf_id']
      act = params['act']
        puts act
      if act == '1'
       respond_to do |format|
         @result = MiniPostFavorite.create(:user_id=>current_user.id,:mini_post_id=>mp_id,:favorite=>true)
         if @result.save
           @return = @result.id
           format.html { render :json => @return }
         else
           @return = -1
           format.html { render :json => @return }
         end
       end  
     elsif act == '0'
       @mini_post_favorite = MiniPostFavorite.find(mpl_id)
       #@mini_post_favorite.deleted=true
       #@mini_post_favorite.liking=false
       #@mini_post_favorite.updated_at=DateTime.now
       #@result =@mini_post_favorite.save

       @result = @mini_post_favorite.destroy
       respond_to do |format|
         @return = 0
         format.html { render :json => @return }
       end
     end
  end
  
   def sharep
     @value = params[:xvalue]
     respond_to do |format|
       if @value.upcase == 'ON'
         @return = "OFF"
         format.html { render :json => @return }
       else
         @return = "ON"
         format.html { render :json => @return }
       end
     end
  end
  
  def sharel
     @value = params[:stype]
     @id = params[:xid]
     @content = params[:xvalue]
     respond_to do |format|
       if @value.upcase == 'ON'
         @return = "OFF"
         format.html  { render :json => {:return => @return, :content => @content, :id => @id } }
       else
         @return = "ON"
         format.html  { render :json => {:return => @return, :content => @content, :id => @id } }
       end
     end
  end
  
  # add the like to a mini_post
  def like
     @mpid = params['mp_id']
     respond_to do |format|
       if MiniPostLiking.create(:user_id=>current_user.id,:mini_post_id=>@mpid,:liking=>true)
         @return = true
         format.html { render :json => @return }
       else
         @return = false
         format.html { render :json => @return }
       end
     end
  end
  
  # remove the like of a mini_post
  def liked
     mpl_id = params['mpl_id']
     @mini_post_likings = MiniPostLiking.find(mpl_id)
     @mini_post_likings.destroy
     respond_to do |format|
       @return = true
       format.html { render :json => @return }
     end
  end
  
  
  def dislike
     @value = params['mp_id']
     respond_to do |format|
       if @mpid
         @return = "ON"
         format.html { render :json => @return }
       else
         @return = "OFF"
         format.html { render :json => @return }
       end
     end
  end
  
  def createNEWKO
    @mini_post = MiniPost.new(params[:mini_post])
      if @mini_post.save
        flash[:notice] = "Post created"
      else
        flash[:error] = "Error! You left some stuff blank."
      end
      redirect_to mini_posts_path
  end
  
  def indexOLDOK
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.feed(last)
    @new_post   = MiniPost.new
   
    # sotto la query definitiva funzionante (wall solo amici) e va integrata con l'endless scrolling page (sopra ) .d4x
    # @mini_posts   = MiniPost.find(:all,:conditions =>['author_id in (?)',current_user.friends.map(&:friend_id)])

    respond_to do |format|
      format.html # index.html.erb
      format.js 
      format.json  { render :json => @mini_posts }
    end
  end

  def indexOLD
    @mini_posts = MiniPost.all
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json  { render :json => @mini_posts }
    end
  end

  def show
    @mini_post = MiniPost.find(params[:id])
    @tags = @mini_post.mini_post_tag;
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mini_posts }
      format.json  { render :json => @tags }
      format.json  { render :json => @comments }
    end
  end

  def new
    @mini_post = MiniPost.new
    @currentid = current_user.id
     respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mini_post }
     end
  end

  def edit
    @mini_post = MiniPost.find(params[:id])
  end

  
  def create
    @mini_post = MiniPost.new(params[:mini_post])
    @mini_post.author_id = current_user.id
    @mini_post.group_id  = params[:group_id]

    if @mini_post.image.present? and @mini_post.content.blank?
      @mini_post.content = "Posted an image"
    end
 #  @tags_ids = params[:mini_post][:tags].delete_if{ |x| x.empty?}
 #  @mini_post.mini_post_tag.destroy_all    
    respond_to do |format|
        if @mini_post.save
          # @tags_ids.each do |ids|
          #   @mini_post.mini_post_tag.create(:mini_post_id => @mini_post.id, :tag_id => ids)  
          # end
          format.html  { redirect_to("/wall", flash[:notice] => t('new post has been created')) }
          format.js { render :json => @mini_post, :status => :created, :location => @mini_post }
        else
          format.html  {redirect_to(request.referer, flash[:notice] => t('invalid image')) }
          format.json  { render :json => @mini_post.errors, :status => :unprocessable_entity }
        end
    end
  end
  
  def update
    @mini_post = MiniPost.find(params[:id])
    @tags_ids = params[:mini_post][:tags].delete_if{ |x| x.empty?}
    @mini_post.post_tag.delete_all    
    @tags_ids.each do |ids|
      @mini_post.post_tag.create(:mini_post_id => @mini_post.id, :tag_id => ids)  
    end 
    respond_to do |format|
      if @mini_post.update_attributes(params[:mini_post])
         format.html  { redirect_to(request.referer,:notice => t('post updated sucessfully')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @mini_post.errors,:status => :unprocessable_entity }
      end
    end
  end

  def login_destroy
      @mini_post = MiniPost.find(params[:id])
      @mini_post.deleted = true
      if @mini_post.update_attributes(params[:mini_post])
        respond_to do |format|
           format.html  { redirect_to(request.referer,:notice => t('post deleted successfully')) }
           format.json { head :no_content }
        end
      end
  end

  def destroy
    @mini_post = MiniPost.find(params[:id])
    @mini_post.destroy
    respond_to do |format|
       format.html  { redirect_to(request.referer,:notice => t('post deleted successfully')) }
       format.json { head :no_content }
    end
  end
  
  def tags_ids
    @mini_post = MiniPost.find(params[:id])
    @mini_post.mini_post_tags.map(&:tag_id)
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
