class Comment < ActiveRecord::Base
  
  belongs_to :post
  attr_accessible :post_id,:author,:author_email,:author_url,:author_ip,:date,:date_gmt,:content,:karma,:approved,:agent,:type,:parent,:user_id

  validates :post_id    ,:presence => true
  validates :author     ,:presence => true, :length => { :minimum => 3 }
  validates :content    ,:presence => true, :length => { :minimum => 3 }
  
end
