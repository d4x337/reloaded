class CreateUserContacts < ActiveRecord::Migration
  def self.up
     create_table :user_contacts do |t|
      t.integer :user_id
      t.integer :contact_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :user_contacts
  end
  
end