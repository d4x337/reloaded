class AddInvitationTokenToCarts < ActiveRecord::Migration
 
  def self.up
    change_table :carts do |t|
       t.string     :invitation_token, :limit => 60
    end
  end
  
  def self.down
      remove_column :carts, :invitation_token, :string
  end
 
end

   