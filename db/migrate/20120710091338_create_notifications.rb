class CreateNotifications < ActiveRecord::Migration
 def self.up
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :target_id
      t.string :reason
      t.text :message
      t.integer :kind_of
      t.boolean :read, :default => false
      t.datetime :sent_at
      t.datetime :read_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :notifications
  end
end
