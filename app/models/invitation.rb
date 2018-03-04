class Invitation < ActiveRecord::Base
  
  attr_accessible :invitation_attributes,:accepted,:read_at,:subject,:recipient_email,:user_id,:sender_id
  
  after_create :send_invitation
  
  belongs_to :user
  
  has_one :recipient, :class_name => 'User'
  
  validates_presence_of :recipient_email,:user_id
#  validates_format_of :recipient_email, :with =>/^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,:allow_blank => false
 
  validate :recipient_is_not_registered
  
  #validate :sender_has_invitations, :if => :sender
  
  before_create :generate_token
  
  #before_create :decrement_sender_count, :if => :sender
  #after_create :send_invitation_mail
  
  private
  
  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end
  
  def sender_has_invitations
    unless sender.invitation_limit > 0
      errors.add_to_base 'You have reached your limit of invitations to send.'
    end
  end
  
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def decrement_sender_count
    sender.decrement! :invitation_limit
  end
    
  def send_invitation
    begin  
      UserMailer.send_invitation(self.id,self.token).deliver
    rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
   end
   
  def set_accepted
    self.accepted = true
    @friends1 = Friend.new(:user_id => current_user.id,:friend_id => self.user_id,:relation =>"FRIEND")
    @friends1.save
    @friends2 = Friend.new(:user_id => self.user_id,:friend_id => current_user.id,:relation =>"FRIEND")
    @friends2.save
  end
  
   
end
