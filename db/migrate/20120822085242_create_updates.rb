class CreateUpdates < ActiveRecord::Migration
 def self.up
    create_table :updates do |t|
      t.integer :sender_id
      t.integer :target_id
      t.string :reason
      t.text :message
      t.boolean :read, :default => false
      t.datetime :read_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :updates
  end
 
end
