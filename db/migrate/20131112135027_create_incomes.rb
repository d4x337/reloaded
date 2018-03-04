class CreateIncomes < ActiveRecord::Migration
 def self.up
    create_table :incomes do |t|
      t.integer :user_id
      t.integer :income_id
      t.integer :order_id
      t.string :status
      t.boolean :una_tantum,:default => false
      t.decimal :income
      t.string :income_type
      t.datetime :expiration
      t.boolean :auto_renew
      t.boolean :deleted,:default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :incomes
  end
end
