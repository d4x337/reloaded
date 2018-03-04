class MiniPostCommentsController < ApplicationController

  before_filter :authenticate_user!
 # protect_from_forgery with: :null_session

  def create
   @mini_post = MiniPost.find(params[:mini_post_id])
    @comment = @mini_post.mini_post_comment.create(:content =>params[:mini_post_comment][:content],:mini_post_id => params[:mini_post_id],:user_id => current_user.id)
    redirect_to(request.referer,:notice => t('Comment added'))
  end

  def destroy
    @comment = MiniPostComment.find(params[:id])
    if (@comment.user_id == current_user.id)
      @comment.destroy
       redirect_to(request.referer,:notice => t('Comment deleted'))
    end
  end

end
