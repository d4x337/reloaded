class AddImageToPosts < ActiveRecord::Migration
 def self.up
    change_table :posts do |t|
      t.attachment :image
    end
  end
  
  def self.down
      remove_column :posts, :image, :attachment
  end
end
