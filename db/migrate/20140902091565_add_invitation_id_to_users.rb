class AddInvitationIdToUsers < ActiveRecord::Migration
   def self.up
    change_table :users do |t|
      t.integer :invitation_id
    end
  end
  
  def self.down
      remove_column :users, :invitation_id, :integer
  end
end
