#encoding: UTF-8
class CreateAds < ActiveRecord::Migration
 def self.up
     create_table :ads do |t|
      t.string :title
      t.string :content
      t.string :url
      t.string :action
      t.integer :active,:default=>0
      t.timestamps
      t.datetime :expire_at
      t.integer :customer_id,:default=>0
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.string :type
      t.string :locale,:default =>'it'
      t.integer :viewed
      t.string :visibility
    end
    add_index :ads, :title, :unique => true
    
    self.load
  end
  
  def self.down
    drop_table :ads
  end
  
  def self.load
     Ad.create(:title=>'La Gazzetta dello Sport',:content=>'Il quotidiano sportivo più letto in Italia',:url=>'http://gazzetta.it',:expire_at=>'',:locale =>'it',:active=>1)
     Ad.create(:title=>'Meetic',:content=>'Incontra Ragazze Single',:url=>'http://meetic.it',:expire_at=>'',:locale =>'it',:active=>1)
     Ad.create(:title=>'Zalando',:content=>'Il più vasto assortimento di Scarpe online',:url=>'http://zalando.it',:expire_at=>'',:locale =>'it',:active=>1)
  end
    
end
