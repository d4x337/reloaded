class CreateCartProducts < ActiveRecord::Migration
 def self.up
      create_table :cart_products  do |t|
        t.integer :cart_id,:null=>false
        t.integer :product_id, :null => false
        t.integer :quantity, :default => 1,:null => false
        t.decimal :single_price
        t.decimal :total_price
        t.string :nickname
        t.string :domain
        t.string :status
 
      end
  end

  def self.down
    drop_table :cart_products
  end
end
