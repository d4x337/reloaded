class AddAboutToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.text :about
      t.string :instagram_id
      t.string :github_id
    end
  end

  def self.down
    remove_column :users, :about, :text
    remove_column :users, :instagram_id, :string
    remove_column :users, :github_id, :string
  end

end