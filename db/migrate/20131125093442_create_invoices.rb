class CreateInvoices < ActiveRecord::Migration
   def self.up
    create_table :invoices do |t|
      t.integer :user_id
      t.integer :order_id
      t.datetime :invoice_date
      t.string :invoice_year
      t.string :email
      t.integer :quantity
      t.boolean :subscription,:default=>true
      t.boolean :annual,:default=>true
      t.datetime :starts_on
      t.datetime :expires_on
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :zip
      t.string :town
      t.string :city
      t.string :country
      t.string :telephone
      t.decimal :total
      t.string :ip_address,:size=>16
      t.boolean :only_services,:default=>false
      t.boolean :payed,:default=>true
      t.boolean :delivered,:default=>false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :invoices
  end
end
