class Friendship < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :friend
end
