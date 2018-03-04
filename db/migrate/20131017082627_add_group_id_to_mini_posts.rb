class AddGroupIdToMiniPosts < ActiveRecord::Migration
 
 def self.up
    change_table :mini_posts do |t|
      t.integer  :group_id, :default=>0
    end
  end
  
  def self.down
      remove_column :mini_posts, :group_id, :integer
  end
 
end