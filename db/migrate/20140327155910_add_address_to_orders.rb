class AddAddressToOrders < ActiveRecord::Migration
 def self.up
    change_table :orders do |t|
       t.string :billing_address
       t.string :billing_email
       t.string :first_pass
    end
  end
  
  def self.down
      remove_column :orders, :billing_address,:string
      remove_column :orders, :billing_email, :string
      remove_column :orders, :first_pass, :string
  end
end
