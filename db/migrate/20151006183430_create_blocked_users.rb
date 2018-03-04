class CreateBlockedUsers < ActiveRecord::Migration
 
  def self.up
    create_table :blocked_users do |t|
      t.integer :user_id
      t.integer :blocked_id
      t.datetime :blocked_at
      t.text :reason,:default=>:null
      t.timestamps
    end
  end
  
  def self.down
    drop_table :blocked_users
  end
  
end