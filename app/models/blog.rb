class Blog < ActiveRecord::Base
   has_one :settings, :class_name => 'BlogSettings'
   has_many :posts, :class_name => 'Post'
   belongs_to :author, :class_name => 'User',:foreign_key=> :owner_id
end
