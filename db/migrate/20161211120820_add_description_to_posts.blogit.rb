# This migration comes from blogit (originally 20150618184415)
class AddDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :text
  end
end
