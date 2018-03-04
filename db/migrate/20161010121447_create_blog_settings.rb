class CreateBlogSettings < ActiveRecord::Migration
  def self.up
   create_table :blog_settings do |t|
      t.integer   :blog_id
      t.string    :border_color
      t.string    :text_color
      t.string    :background_color
      t.boolean   :allow_comments,:default=>true
   end
  end

  def self.down
    drop table :blog_settings
  end
end
