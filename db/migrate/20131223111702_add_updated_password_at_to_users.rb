class AddUpdatedPasswordAtToUsers < ActiveRecord::Migration

  def self.up
    change_table :users do |t|
      t.datetime :updated_password_at
    end
  end
  
  def self.down
      remove_column :users, :updated_password_at, :datetime
  end
 
end
