class UserContact < ActiveRecord::Base
  attr_accessible :user_id,  :contact_id
  belongs_to :user, :foreign_key => :user_id
  has_many :contacts,:class_name => 'User', :foreign_key => :contact_id
end
