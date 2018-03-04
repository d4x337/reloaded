#encoding: UTF-8
class CreatePosts < ActiveRecord::Migration
  
  def self.up
  	create_table :posts do |t|
  		t.text			:title
  		t.text			:content
  		t.integer		:author
  		t.datetime	:date
  		t.datetime	:gmt
  		t.text			:excerpt
  		t.string		:status
  		t.string    :visibility
  		t.string		:comment_status
  		t.string		:ping_status
  		t.string		:password
  		t.string		:name
  		t.text			:to_ping
  		t.text			:pinged
  		t.datetime  :published
  		t.datetime	:modified
  		t.datetime	:modified_gmt
  		t.text			:content_filtered
  		t.integer		:parent, :default => 0
  		t.string		:guid
  		t.integer		:menu_order, :default => 0
  		t.string		:content_type
  		t.string		:mime_type
  		t.integer		:comment_count, :default => 0
  		t.timestamps
  	  end

  end
  
  def self.down
  	 drop_table :posts
  end

end
