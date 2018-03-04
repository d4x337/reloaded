class CreateMessages < ActiveRecord::Migration
  
  def self.up
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :target_id
      t.integer :chat_id
      t.string :target_name
      t.string :notify_link
      t.string :read_token
      t.text :sha512
      t.text :bfk
      t.text :tfk
      t.text :tfe
      t.text :aek
      t.text :tdk
      t.text :tde
      t.text :encoded
      t.text :decoded
      t.text :public_key
      t.text :cipher
      t.text :private_key
      t.boolean :delivered,:default=>false
      t.text :content,:limit => 1337
      t.boolean :secured, :default => false
      t.string :public
      t.string :private
      t.string :msghash
      t.string :link
      t.boolean :autodestroy,:default => true
      t.string :message,:limit => 255
      t.boolean :deleted, :default=>false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :messages
  end
end
