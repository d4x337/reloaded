class AddFieldsToUsers < ActiveRecord::Migration
   def self.up
    change_table :users do |t|
     
      t.string :twitter_user
      t.string :facebook_user
     
     
      t.text :favourite_quote
     
   end
  end
  
  def self.down
     
      remove_column :users, :twitter_user, :string
      remove_column :users, :facebook_user, :string
     
      remove_column :users, :favourite_quote, :text
  
    end
end
