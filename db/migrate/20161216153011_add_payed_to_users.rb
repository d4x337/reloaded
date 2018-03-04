class AddPayedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment, :string
    add_column :users, :coupon, :string
    add_column :users, :subscription_start, :datetime
    add_column :users, :subscription_end, :datetime
    add_column :users, :payed, :boolean,:default=>true
  end
end
