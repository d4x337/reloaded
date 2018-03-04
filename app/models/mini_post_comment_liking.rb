class MiniPostCommentLiking < ActiveRecord::Base
    attr_accessible :user_id,:mini_post_comment_id,:liking,:created_at,:deleted
    belongs_to :user
    belongs_to :mini_post_comment
   
    validates :mini_post_comment_id, :presence => true
    validates :user_id, :presence => true

 #   include PublicActivity::Model
 #   tracked
end
