class WallController < ApplicationController
  
  before_filter :authenticate_user!
  #load_and_authorize_resource
  layout 'social'

  def timeline
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
     respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @mini_posts }
    end
  end

  def liked
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @mini_posts }
    end
  end

  def disliked
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @mini_posts }
    end
  end

  def favorited
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @mini_posts }
    end
  end

  def indexupd
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(7).order(:created_at).reverse_order
    render :partial => "/wall/mini_post", :layout=> false, :collection => @mini_posts

  end

  def index
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(7).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
     respond_to do |format|
      format.html
      format.js { render :json => @mini_posts }
    end
  end

  def mytimeline
    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user,last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
    respond_to do |format|
      format.html
      format.js { render :json => @mini_posts }
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

  def create
    @mini_post = MiniPost.new(params[:mini_post])
      if @mini_post.save
        flash[:notice] = "Post successfully created!"
      else
        flash[:error] = "Error! You left some stuff blank."
      end
      redirect_to mini_posts_path
  end
   
  def preview
    @mini_post = MiniPost.new(params[:mini_post])
    render :text => @mini_post.content_html
  end

end
