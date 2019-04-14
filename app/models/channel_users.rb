class ChannelUsers < ActiveRecord::Base
  attr_accessible :channel_id, :user_id, :join_at, :invited
end
