class Tag < ActiveRecord::Base
  validates :name,:slug, :presence => true;
  has_many :post_tag,:foreign_key => :post_id
  has_many :mini_post_tag,:foreign_key => :mini_post_id
  has_many :link_tag,:foreign_key => :link_id
  
  attr_accessible :name,:slug
  # PublicActivity::Model
 #tracked

  include PgSearch
  multisearchable :against => [:name]
end
