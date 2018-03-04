class CreatePaymentNotifications < ActiveRecord::Migration

  def self.up
    create_table :payment_notifications do |t|
      t.integer :cart_id
      t.text :params
      t.string :status
      t.string :transaction_id
      t.timestamps
    end
  end
    
  def self.down
    drop_table :payment_notifications
  end

end
