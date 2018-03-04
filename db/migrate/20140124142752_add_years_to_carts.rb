class AddYearsToCarts < ActiveRecord::Migration
  def self.up
    change_table :carts do |t|
      t.integer  :years
    end
  end
  
  def self.down
      remove_column :carts, :years, :integer
  end
 
end