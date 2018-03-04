class CreateMiniPostLikings < ActiveRecord::Migration
  def self.up
      create_table :mini_post_likings  do |t|
        t.boolean :liking,:default => true
        t.datetime :created_at, :null => false
        t.integer :mini_post_id, :default => 0,:null => false
        t.integer :user_id,:default => 0,:null => false
        t.boolean :deleted,:default =>false
      end

  end

  def self.down
    drop_table :mini_post_likings
  end
end
