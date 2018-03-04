class TimelineController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy,:crop]
  layout "iposts"

  def index
    get_and_show_posts
  end

  def admin
    get_and_show_posts
  end

  def index_with_button
    get_and_show_posts
  end

  def show
    @post = MiniPost.find_by_id(params[:id])
  end

  private

  def get_and_show_posts
 #   @posts = Ipost.paginate(page: params[:page], per_page: 15).order('created_at ASC')
 #   respond_to do |format|
 #     format.html
 #     format.js
 #   end

    last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @mini_posts = MiniPost.where('author_id in (?) and created_at < ?',current_user.friends.map(&:friend_id).push(current_user.id),last).page(params[:page]).limit(10).order(:created_at).reverse_order
    @feedlist = Feed.where(:locale=>current_user.locale,:active=>true).order(:feedtext)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @mini_posts }
    end
  end

  def set_post
    @post = MiniPost.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :title, :body)
  end
end
