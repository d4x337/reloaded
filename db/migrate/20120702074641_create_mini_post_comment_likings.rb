class CreateMiniPostCommentLikings < ActiveRecord::Migration
   def self.up
      create_table :mini_post_comment_likings do |t|
        t.boolean :liking
        t.datetime :created_at, :null => false
        t.integer :mini_post_comment_id, :default => 0,:null => false
        t.integer :user_id, :default => 0,:null => false
        t.boolean :deleted,:default =>false
      end
      #add_index "user_id",:name => "fk_user_liking_mpc"
      #add_index "mini_post_comment_id",:name => "fk_comm_liking_mpc"
  end

  def self.down
    drop_table :mini_post_comment_likings
  end
end
