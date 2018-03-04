class Friend < ActiveRecord::Base
  
  FRIEND_TYPES = %w[FRIEND CLOSE_FRIEND CUSTOM ACQUAINTANCE COLLEGUE PARENT, ENEMY]
  
  belongs_to :user
  
  validates :user_id,:friend_id, :presence => true
  
  validates :relation, :inclusion => { :in => FRIEND_TYPES }

  after_create :send_added_to_ring_message
  
 # after_destroy :send_removed_from_ring_message
  
  private
  def send_added_to_ring_message
    UserMailer.added_to_ring(self.id).deliver
  end
  
  def send_removed_from_ring_message
    UserMailer.removed_from_ring(self.id).deliver
  end
  
end
