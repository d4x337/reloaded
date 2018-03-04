class AddTargetIdToRequests < ActiveRecord::Migration
  def self.up
    change_table :requests do |t|
      t.integer :target_id
    end
  end
  
  def self.down
      remove_column :requests, :target_id, :integer
  end
end
