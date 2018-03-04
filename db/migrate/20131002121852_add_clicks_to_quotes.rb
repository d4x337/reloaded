class AddClicksToQuotes < ActiveRecord::Migration
  
  def self.up
    change_table :quotes do |t|
      t.integer :clicks
      t.integer :rating
      t.datetime :published
    end
  end
  
  def self.down
      remove_column :quotes, :clicks, :integer
      remove_column :quotes, :rating, :integer
      remove_column :quotes, :published, :datetime
  end
 
end
