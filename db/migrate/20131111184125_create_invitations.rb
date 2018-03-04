class CreateInvitations < ActiveRecord::Migration
  
   def self.up
    create_table :invitations do |t|
      t.integer :user_id
      t.string :recipient_email
      t.string :token
      t.datetime :sent_at
      t.string :subject
      t.text :reason
      t.boolean :accepted,:default => false
      t.boolean :email_sent,:default => false
      t.boolean :archivied,:default => false
      t.datetime :read_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :invitations
  end
    
end
