class AddRequestTokenToCarts < ActiveRecord::Migration
  
  def self.up
    change_table :carts do |t|
      t.string  :request_token
    end
  end
  
  def self.down
      remove_column :carts, :request_token, :string
  end
 
end