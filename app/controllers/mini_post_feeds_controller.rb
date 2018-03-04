class MiniPostFeedsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @mini_post = MiniPost.find(params[:mini_post_id])
    @feed = @mini_post.mini_post_feed.create(:feedtag =>params[:mini_post_feed][:feedtag],:mini_post_id => params[:mini_post_id],:user_id => current_user.id)
    redirect_to(request.referer,:notice => 'Feed added')
    
  end
  
  def destroy
    @feed = MiniPostFeed.find(params[:id])
    if (@feed.user_id == current_user.id)
      @feed.destroy
       redirect_to(request.referer,:notice => 'Feed deleted')
    else
      
    end
  end

end
