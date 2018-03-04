class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :order_id,:default=>0
      t.string :domain
      t.string :nick
      t.string :prod_id
      t.integer :items
      t.string :currency
      t.string :status
      t.string :promo
      t.decimal :total_price
      t.string :ip
      t.datetime :purchased_at
      t.datetime :last_operation   
      t.boolean :deleted,:default=>false
      t.timestamps
    end
  end
    
  def self.down
    drop_table :carts
  end

end
