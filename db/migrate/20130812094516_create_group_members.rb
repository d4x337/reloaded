class CreateGroupMembers < ActiveRecord::Migration

   def self.up
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :role
      t.integer :invited_by
      t.integer :promoted_by
      t.integer :removed_by
      t.datetime :join_date
      t.datetime :leave_date
      t.boolean :active,:default => true
      t.timestamps
    end
  end
  
  def self.down
    drop_table :group_members
  end

end
