class CreateBlogs < ActiveRecord::Migration
  def self.up
   create_table :blogs do |t|
      t.integer   :owner_id
      t.string    :title
      t.string    :motto
      t.text      :description
   end
  #  self.load
  end

  def self.down
    drop table :blogs
  end

  def self.down
    Blog.create  :owner_id => 1, :title => 'd4x337blog',:motto=>'tech & geek lifestyle'
  end
end
