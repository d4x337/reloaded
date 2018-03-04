class AddInvitationIdToCarts < ActiveRecord::Migration
  
  def self.up
    change_table :carts do |t|
      t.integer  :invitation_id
    end
  end
  
  def self.down
      remove_column :carts, :invitation_id, :integer
  end
 
end