class CartItem < ActiveRecord::Base

  belongs_to :product,:foreign_key=> :product_id
  attr_accessible :cart_id, :product_id, :quantity, :single_price, :vats, :total_price, :shipping_costs, :is_in_stock, :last_operation, :deleted
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