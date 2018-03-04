class CreatePhoneNumbers < ActiveRecord::Migration

  def self.up
    create_table :phone_numbers do |t|
     t.string :user_id
      t.string :phone_number
      t.string :pin
      t.string :action_type
      t.boolean :verified,:default=>false
      t.boolean :authenticated,:default=>false
      t.datetime :verified_at
      t.boolean :confirm,:default=>false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :phone_numbers
  end
  
end