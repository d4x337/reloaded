class Comment < ActiveRecord::Base
  
  belongs_to :post
  validates :post_id    ,:presence => true
  validates :author     ,:presence => true, :length => { :minimum => 3 }
  validates :content    ,:presence => true, :length => { :minimum => 3 }
  
end
