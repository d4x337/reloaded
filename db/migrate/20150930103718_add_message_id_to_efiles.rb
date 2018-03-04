class AddMessageIdToEfiles < ActiveRecord::Migration
  def self.up
    change_table :efiles do |t|
      t.integer :message_id
    end
  end
  
  def self.down
      remove_column :efiles, :message_id, :integer
  end
end