class AddRivacySettings < ActiveRecord::Migration
  
 def self.up
    change_table :users do |t|
      t.integer :email_privacy,:default=>0
      t.integer :picture_privacy,:default=>0
      t.integer :status_privacy,:default=>0
      t.integer :last_access_privacy,:default=>0
      t.integer :global_search_privacy,:default=>0
    end
  end
  
  def self.down
      remove_column :users, :email_privacy, :integer
      remove_column :users, :picture_privacy, :integer
      remove_column :users, :status_privacy, :integer
      remove_column :users, :last_access_privacy, :integer
      remove_column :users, :global_search_privacy, :integer
  end
end