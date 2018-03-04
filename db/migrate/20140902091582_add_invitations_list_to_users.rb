class AddInvitationsListToUsers < ActiveRecord::Migration

  def self.up
    change_table :users do |t|
      t.attachment :invitations_list
    end
  end
  
  def self.down
      remove_column :users, :invitations_list, :attachment
  end
end