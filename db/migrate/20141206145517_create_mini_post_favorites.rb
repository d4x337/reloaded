class CreateMiniPostFavorites < ActiveRecord::Migration
 def self.up
      create_table :mini_post_favorites  do |t|
        t.boolean :favorite,:default => true
        t.datetime :created_at, :null => false
        t.integer :mini_post_id, :default => 0,:null => false
        t.integer :user_id,:default => 0,:null => false
        t.boolean :deleted,:default =>false
      end
      #add_index "user_id",:name => "fk_user_liking_mp"
      #add_index "mini_post_id",:name => "fk_comm_liking_mp"
  end

  def self.down
    drop_table :mini_post_favorites
  end
end
