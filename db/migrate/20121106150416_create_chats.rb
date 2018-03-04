class CreateChats < ActiveRecord::Migration
   def self.up
    create_table :chats do |t|
      t.integer :sender_id
      t.integer :target_id
      t.string :from, :limit => 255, :null => false, :default => ''
      t.string :to, :limit => 255, :null => false, :default => ''
      t.text :message, :null => false
      t.timestamp :sent, :null => false, :dafault => '0000-00-00 00:00:00'
      t.integer :recd, :null => false, :default => 0
      t.timestamps
    end
    add_index :chats, :from
    add_index :chats, :to
  end

  def self.down
    drop_table :chats
  end

end
