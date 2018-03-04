class AddOrderIdToUsers < ActiveRecord::Migration
  
  def self.up
    change_table :users do |t|
      t.integer  :order_id
    end
  end
  
  def self.down
      remove_column :users, :order_id, :integer
  end
 
end