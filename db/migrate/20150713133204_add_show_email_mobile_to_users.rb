class AddShowEmailMobileToUsers < ActiveRecord::Migration
 
  def self.up
    change_table :users do |t|
      t.boolean :show_email,:default=>true
      t.boolean :show_mobile,:default=>true
      t.boolean :show_last_access,:default=>true
    end
  end

  def self.down
    remove_column :users, :show_email,:boolean
    remove_column :users, :show_mobile,:boolean
    remove_column :users, :show_last_access,:boolean
  end
  
end
