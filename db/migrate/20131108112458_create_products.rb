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
    Product.create :name => "Agadanga Beta Test 50Mb",:description => "VPN Access",:category =>'service',:quota=>"50000000S",:currency => "Euro",:final_price => 0.00,:summary=>"FREE",:subscription => "free"
    Product.create :name => "AgadangaBox 1GB",:description => "1GB email agadanga",:category =>'service',:quota=>"1000000000S",:currency => "Euro",:final_price => 5.00,:subscription => "unatantum"
    Product.create :name => "AgadangaBox 3GB",:description => "3GB email agadanga",:category =>'service',:quota=>"3000000000S",:currency => "Euro",:final_price => 10.00,:subscription => "unatantum"
    Product.create :name => "AgadangaBox 20GB",:description => "20GB email Agadanga",:category =>'service',:quota=>"20000000000S",:currency => "Euro",:final_price => 30.00,:subscription => "unatantum"
    Product.create :name => "T-shirt",:description => "Official T-shirt ",:category =>'product',:currency => "Euro",:final_price => 25.00,:subscription => "single"
    Product.create :name => "Hat",:description => "Official Agadanga Hat",:category =>'product',:currency => "Euro",:final_price => 20.00,:subscription => "single"
    Product.create :name => "Mug",:description => "Official Agadanga Mug",:category =>'product',:currency => "Euro",:final_price => 15.00,:subscription => "single"
    Product.create :name => "Sweater",:description => "Official Agadanga Sweater",:category =>'product',:currency => "Euro",:final_price => 40.00,:subscription => "single"
    Product.create :name => "Bag",:description => "Official Agadanga Bag",:category =>'product',:currency => "Euro",:final_price => 50.00,:subscription => "single"
    Product.create :name => "Poster",:description => "agadanga Posters",:category =>'product',:currency => "Euro",:final_price => 20.00,:subscription => "single"
    Product.create :name => "OpenBSD 5.5",:description => "Operating System DVD Cases",:category =>'product',:currency => "Euro",:final_price => 50.00,:subscription => "single"
    Product.create :name => "VPN Access",:description => "VPN Access",:category =>'service',:currency => "Euro",:final_price => 20.00,:subscription => "annual"
  end
end
