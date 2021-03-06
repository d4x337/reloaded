class MiniPostLiking < ActiveRecord::Base
  
    attr_accessible :mini_post_id,:liking,:user_id,:deleted
   
    belongs_to :user
    belongs_to :mini_post
    
    validates :mini_post_id, :presence => true
    validates :user_id, :presence => true

end
