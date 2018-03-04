class MiniPosts < ActiveRecord::Migration
  def self.up
    create_table :mini_posts do |t|
      t.integer :author_id
      t.text    :content
      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size
      t.timestamps
      t.string  :ext_url
      t.string  :visibility,:default=>'FRIEND'
      t.string  :comment_status
      t.boolean :is_a_comment,:default => false
      t.boolean :has_image,:default => false
      t.boolean :has_url,:default => false
      t.integer :likes,:default => 0
      t.integer :dislikes,:default => 0
      t.integer :rating
      t.integer :popularity
      t.integer   :parent_mini_post_id, :default => 0
      t.boolean :is_delay_publish,:default => false
      t.datetime  :delay_publish_date
      t.boolean :is_auto_destroy,:default => false
      t.datetime :destroy_at
      t.boolean :removed
      t.string :rem_category
      t.text :reason
      t.string :author_ip
      t.string :author_device
      t.text  :review_admin_notes
      t.boolean :deleted,:default => false
      t.timestamps
    end
     
  end
  
  def self.down
     drop_table :mini_posts
  end
  
  def self.load
    MiniPost
  end

end
