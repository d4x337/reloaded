class AddFieldsToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.boolean :is_encrypted, :default=>false
      t.string :encoded_filename
      t.string :encoded_size
      t.string :encrypted_key
      t.string :encrypted_key_salt
      t.string :encrypted_key_iv
      t.string :encrypted_entropy
      t.string :encrypted_entropy_salt
      t.string :encrypted_entropy_iv
      t.boolean :compressed,:default=>false
    end
  end
  
  def self.down
      remove_column :uploads, :is_encrypted, :boolean
      remove_column :uploads, :encoded_filename, :string
      remove_column :uploads, :encoded_size, :string
      remove_column :uploads, :encrypted_key, :string
      remove_column :uploads, :encrypted_key_salt, :string
      remove_column :uploads, :encrypted_key_iv, :string
      remove_column :uploads, :encrypted_entropy, :string
      remove_column :uploads, :encrypted_entropy_salt, :string
      remove_column :uploads, :encrypted_entropy_iv, :string
      remove_column :uploads, :compressed, :boolean
  end
 
end
     