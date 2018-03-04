class Chat < ActiveRecord::Base
  
   has_many :messages,:class_name=>'Message',:foreign_key=>:chat_id, :dependent => :destroy
   attr_accessible :sender_id, :target_id, :from, :to, :message, :sent
end
