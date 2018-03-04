class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :user_id
      t.string :fullname
      t.string :target_email
      t.text :message
      t.string :relation,:default=>'PR'
      t.string :status,:default => 'PENDING'
      t.boolean :answered,:default => false
      t.datetime :used_on
      t.datetime :last_operation_on
      t.datetime :expires_on
      t.boolean :never_expires,:default=>true
      t.boolean :know_in_real_world,:default=>true
      t.boolean :deleted,:default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :requests
  end
end
