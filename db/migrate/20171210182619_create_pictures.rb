class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :user_id
      t.integer :album_id,:default=>0
      t.string  :caption
      t.string  :pic_file_name
      t.string  :pic_content_type
      t.integer :pic_file_size
      t.boolean :deleted,:default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
