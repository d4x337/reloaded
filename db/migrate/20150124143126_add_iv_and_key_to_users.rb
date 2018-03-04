class AddIvAndKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :iv, :binary
    add_column :users, :key, :binary
  end
end
