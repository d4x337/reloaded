class Status < ActiveRecord::Base
  
  attr_accessible :user_id,:current,:status,:set_at
  
  belongs_to :user
  
end
