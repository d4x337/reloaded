class PostTag < ActiveRecord::Base
  has_many :tag, :foreign_key => :id
  has_many :post,:foreign_key => :post_id
  validates :post_id, :tag_id, :presence => true
  attr_accessible :post_id, :tag_id
end
