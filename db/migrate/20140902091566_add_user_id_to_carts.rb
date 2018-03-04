class AddUserIdToCarts < ActiveRecord::Migration
 def self.up
    change_table :carts do |t|
      t.integer :user_id
    end
  end
  
  def self.down
      remove_column :user_id, :carts, :integer
  end
end
