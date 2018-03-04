class AddEncSharedToUsers < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.text :enc_shared
    end
  end
  
  def self.down
      remove_column :messages, :enc_shared, :text
  end
end