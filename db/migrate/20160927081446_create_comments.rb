class CreateComments < ActiveRecord::Migration
   def self.up
   create_table :comments do |t|
      t.integer   :post_id
      t.text      :author
      t.string    :author_email
      t.string    :author_url
      t.string    :author_ip
      t.datetime  :date
      t.datetime  :date_gmt
      t.text      :content
      t.integer   :karma
      t.string    :approved
      t.string    :agent
      t.string    :type
      t.integer   :parent
      t.string    :user_id 
   end
  end

  def self.down
    drop table :comments
  end
  
end
