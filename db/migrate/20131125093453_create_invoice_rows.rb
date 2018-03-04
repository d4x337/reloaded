class CreateInvoiceRows < ActiveRecord::Migration
   def self.up
    create_table :invoice_rows do |t|
      t.integer :product_id
      t.decimal   :single
      t.integer :quantity
      t.decimal :total
      t.decimal   :vats
      t.boolean :in_stock
      t.datetime :arrival_date
      t.boolean :shipped,:default => false
      t.boolean :payed,:default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :invoice_rows
  end
end
