class Update < ActiveRecord::Base

#  belongs_to :user,:class_name=>'User', :foreign_key => :user_id
  
  attr_accessible :sender_id,:target_id,:read,:reason,:created_at,:read_at,:message
    # attr_accessible :title, :body
  has_one :sender, :class_name=>'User', :foreign_key => :sender_id
  has_one :destination, :as => :user, :foreign_key => :target_id
  validates :sender_id,:target_id, :presence => true
end
