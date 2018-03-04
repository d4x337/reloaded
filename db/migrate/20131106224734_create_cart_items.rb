class CreateCartItems < ActiveRecord::Migration
  
  def self.up
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity
      t.float :single_price
      t.float :vats
      t.float :total_price
      t.float :shipping_costs
      t.boolean :is_in_stock
      t.datetime :last_operation   
      t.boolean :deleted,:default=>false
      t.timestamps
    end
  end
    
  def self.down
    drop_table :cart_items
  end

end
