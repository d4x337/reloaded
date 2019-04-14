class Channel < ActiveRecord::Base
  attr_accessible :user_id, :name, :banner, :chan_type, :last_message, :current_users, :max_users,:reason
end
