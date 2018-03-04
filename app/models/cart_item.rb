class CartItem < ActiveRecord::Base

  #acts_as_shopping_cart_item

  belongs_to :product,:foreign_key=> :product_id
  #belongs_to :cart, :foreign_key => :cart_id,:class_name=>'Cart'
  
  before_create :default_quantity_to_one
  
  def unit_price
    product.price
  end
  
  def full_price
    unit_price*quantity
  end
  
  private
  def default_quantity_to_one
    self.quantity ||= 1
  end

end