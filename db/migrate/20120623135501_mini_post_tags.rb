class MiniPostTags < ActiveRecord::Migration
 def self.up
    create_table :mini_post_tags do |t|
      t.integer :mini_post_id
      t.integer :tag_id
      t.timestamps
    end
    self.load
  end
  
  def self.down
     drop_table :mini_post_tags
  end
  
  def self.load
    
  end
  
end
