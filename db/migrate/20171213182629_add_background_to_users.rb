class AddBackgroundToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :background
    end
  end

  def self.down
    remove_column :users, :background, :string
  end

end