class MiniPostComments < ActiveRecord::Migration
   def self.up
  create_table :mini_post_comments do |t|
    
      t.integer   :mini_post_id
      t.integer   :user_id
      t.datetime  :created_at
      t.string    :author_ip
      t.text      :content
      t.integer   :karma
      t.boolean   :approved, :default => false
      t.boolean   :deleted,:default => false
      t.boolean   :removed,:default => false
      t.text      :removal_reason
      t.integer   :moderator
      t.string    :user_agent
      t.string    :user_arch
      t.integer   :parent_id,:default => 0
   end
  end
  def self.down
    drop_table    :mini_post_comments
  end
end
