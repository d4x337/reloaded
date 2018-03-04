class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
      t.integer :user_id
      t.string :name
      t.text :banner
      t.string :chan_type
      t.datetime :last_message
      t.integer :current_users
      t.integer :max_users
      t.text :reason,:default=>:null
      t.timestamps
    end
  end
  
  def self.down
    drop_table :channels
  end
  
end