class MiniPostFeed < ActiveRecord::Base
  
  belongs_to :mini_post,:class_name => 'MiniPost', :foreign_key => :mini_post_id
  belongs_to :user,:class_name => 'User', :foreign_key => :user_id
  belongs_to :feed,:class_name => 'Feed', :foreign_key => :feedtag
   
  validates :mini_post_id    ,:presence => true
  validates :user_id     ,:presence => true
  validates :feedtag    ,:presence => true
  
end