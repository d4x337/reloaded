class GroupMember < ActiveRecord::Base
   attr_accessible :group_id, :user_id, :role, :invited_by, :promoted_by, :removed_by, :join_date, :leave_date, :active
   belongs_to :user
   belongs_to :group
  
end
