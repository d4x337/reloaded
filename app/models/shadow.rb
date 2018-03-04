class Shadow < ActiveRecord::Base
  
  attr_accessible :sender_id,:sender_email,:content,:recipient_id,:recipient_email

end
