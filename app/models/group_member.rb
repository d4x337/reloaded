class GroupMember < ActiveRecord::Base
  # attr_accessible :title, :body
   belongs_to :user
   belongs_to :group
  
end
