class AddBlogidToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.integer :blog_id
    end
  end
  
  def self.down
      remove_column :posts, :blog_id, :integer
  end
end