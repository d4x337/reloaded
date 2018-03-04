class BlockedUser < ActiveRecord::Base
  attr_accessible :user_id,:blocked_id,:reason
  belongs_to :user,:foreign_key=>:user_id
  has_many :banned,:foreign_key=>:blocked_id
end
