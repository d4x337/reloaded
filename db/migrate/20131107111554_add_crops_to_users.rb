class AddCropsToUsers < ActiveRecord::Migration
 def self.up
    change_table :users do |t|
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_w
      t.integer :crop_h
    end
  end
  
  def self.down
      remove_column :users, :crop_x, :integer
      remove_column :users, :crop_y, :integer
      remove_column :users, :crop_w, :integer
      remove_column :users, :crop_h, :integer
  end
 
end
