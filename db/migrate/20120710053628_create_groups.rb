class CreateGroups < ActiveRecord::Migration
 def self.up
    create_table :groups do |t|
      t.integer :user_id
      t.string :title
      t.string :headline
      t.text :description
      t.text :motto
      t.string :founder
      t.integer :members
      t.integer :admins
      t.string :visibility,:default =>'PUBLIC'
      t.datetime :creation_date
      t.text :mission
      t.boolean :deleted,:default => false
      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size
      t.string  :cover_file_name
      t.string  :cover_content_type
      t.integer :cover_file_size
      t.timestamps
    end
  end
  
  def self.down
    drop_table :groups
  end
end
