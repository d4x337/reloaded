class AddAviContentTypeToUsers < ActiveRecord::Migration
  
  def self.up
    change_table :users do |t|
      t.string :avi_content_type
    end
  end
  
  def self.down
      remove_column :users, :avi_content_type, :string
  end
 
end
