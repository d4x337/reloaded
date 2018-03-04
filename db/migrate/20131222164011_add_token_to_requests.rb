class AddTokenToRequests < ActiveRecord::Migration
 def self.up
    change_table :requests do |t|
      t.string  :token
    end
  end
  
  def self.down
      remove_column :requests, :token, :string
  end
 
end