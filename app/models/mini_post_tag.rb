class MiniPostTag < ActiveRecord::Base
  has_many :tag, :foreign_key => :id
  has_many :mini_post,:foreign_key => :mini_post_id
  validates :mini_post_id, :tag_id, :presence => true
  attr_accessible :mini_post_id, :tag_id
end
