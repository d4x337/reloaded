class CartProduct < ActiveRecord::Base
  belongs_to :cart,:foreign_key => :cart_id
  belongs_to :product, :foreign_key => :product_id
  
  validates :cart_id, :product_id, :presence => true
end
