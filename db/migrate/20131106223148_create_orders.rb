class CreateOrders < ActiveRecord::Migration
   def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cart_id
      t.integer :quantity
      t.boolean :subscription,:default=>true
      t.boolean :annual,:default=>true
      t.datetime :starts_on
      t.datetime :expires_on
      t.string :email
      t.integer :invoice_id
      t.string :ip_address,:size=>16
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :zip
      t.string :city
      t.string :town
      t.string :country
      t.string :telephone
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address
      t.string :shipping_zip
      t.string :shipping_city
      t.string :shipping_town
      t.string :shipping_country
      t.string :shipping_telephone
      t.text :customer_notes
      t.text :internal_notes
      t.decimal :total
      t.boolean :only_services,:default=>false
      t.boolean :payed,:default=>false
      t.boolean :delivered,:default=>false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :orders
  end
end
