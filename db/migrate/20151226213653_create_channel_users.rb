class CreateChannelUsers < ActiveRecord::Migration
   def self.up
    create_table :channel_users do |t|
      t.integer :channel_id
      t.string :user_id
      t.datetime :join_at
      t.boolean :invited,:default=>:false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :channel_users
  end
  
end