class FixContraints < ActiveRecord::Migration
  def change
    remove_index :mini_post_likings, [:user_id, :mini_post_id]
  end
end
