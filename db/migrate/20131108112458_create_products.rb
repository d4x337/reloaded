class CreateProducts < ActiveRecord::Migration
 def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :summary
      t.float :final_price
      t.float :costs
      t.string :category
      t.string :currency
      t.string :quota
      t.string :subscription
      t.boolean :pay_once
      t.boolean :in_stock,:default => true
      t.boolean :promo,:default => false
      t.boolean :active,:default => true
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
    self.load
  end
  
  def self.down
    drop_table :products
  end
  
  def self.load
    Product.create :name => "Reloaded Blog",:description => "Reloaded Blog Service",:category =>'service',:quota=>"3000000000S",:currency => "Euro",:final_price => 25.00,:subscription => "anual"
    Product.create :name => "Reloaded Mailbox 3GB",:description => "3GB Mailbox",:category =>'service',:quota=>"3000000000S",:currency => "Euro",:final_price => 3.00,:subscription => "anual"
    Product.create :name => "Reloaded Mailbox 10GB",:description => "10GB Mailbox",:category =>'service',:quota=>"10000000000S",:currency => "Euro",:final_price => 10.00,:subscription => "anual"
    Product.create :name => "Reloaded Mailbox 20GB",:description => "20GB Mailbox",:category =>'service',:quota=>"20000000000S",:currency => "Euro",:final_price => 20.00,:subscription => "anual"
    Product.create :name => "T-shirt",:description => "Reloaded T-shirt ",:category =>'product',:currency => "Euro",:final_price => 20.00,:subscription => "single"
    Product.create :name => "Mug",:description => "Reloaded Mug",:category =>'product',:currency => "Euro",:final_price => 15.00,:subscription => "single"
    Product.create :name => "Stickers",:description => "Reloaded Stickers",:category =>'product',:currency => "Euro",:final_price => 5.00,:subscription => "single"
  end
end
