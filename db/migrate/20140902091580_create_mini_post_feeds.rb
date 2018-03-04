class CreateMiniPostFeeds < ActiveRecord::Migration

  def self.up
    create_table :mini_post_feeds do |t|
      t.integer :mini_post_id
      t.integer :user_id
      t.string :feedtag
      t.timestamps
    end
  end
  
  def self.down
     drop_table :mini_post_feeds
  end
  
end
