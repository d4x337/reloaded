class AddTwoFactorToUsers < ActiveRecord::Migration
  
  def self.up
    change_table :users do |t|
      t.string   :otp_secret_key
      t.integer  :second_factor_attempts_count, :default => 0
      t.boolean  :two_factor_enabled,:default=>false
      t.datetime :mobile_confirmed_at
    end
  end

  def self.down
    remove_column :users, :otp_secret_key,:string
    remove_column :users, :second_factor_attempts_count,:integer
    remove_column :users, :two_factor_enabled,:boolean
    remove_column :users, :mobile_confirmed_at,:datetime
  end
  
end