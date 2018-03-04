class CreateEfiles < ActiveRecord::Migration
 
 def self.up
    create_table :efiles do |t|
      t.integer :user_id
      t.attachment :original
      t.string :encoded_filename
      t.string :encoded_size
      t.string :encrypted_key
      t.string :encrypted_key_salt
      t.string :encrypted_key_iv
      t.string :encrypted_entropy
      t.string :encrypted_entropy_salt
      t.string :encrypted_entropy_iv
      t.boolean :compressed,:default=>false
      t.timestamps
   end
 end
  
 def self.down
   drop_table :efiles
 end
 
end