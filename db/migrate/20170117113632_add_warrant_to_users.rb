class AddWarrantToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :warrant,:default=>false
      t.string :warrant_code
      t.string :warrant_date,:default=>nil
      t.text :warrant_notes
    end
  end

  def self.down
    remove_column :users, :warrant, :boolean
    remove_column :users, :warrant_code, :string
    remove_column :users, :warrant_date, :string
    remove_column :users, :warrant_notes, :text
  end
end
