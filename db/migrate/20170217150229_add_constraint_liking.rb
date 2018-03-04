class AddConstraintLiking < ActiveRecord::Migration
  def change
    add_index :mini_post_likings, [:user_id, :mini_post_id], :unique => true
  end
end
