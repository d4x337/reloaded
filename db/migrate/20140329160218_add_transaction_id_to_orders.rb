class AddTransactionIdToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
       t.string :transaction_id
       t.string :status
       t.string :amount
       t.string :currency
    end
  end
  
  def self.down
      remove_column :orders, :transaction_id,:string
      remove_column :orders, :status,:string
      remove_column :orders, :amount, :date
      remove_column :orders, :currency, :string
  end

end
