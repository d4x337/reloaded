class Request < ActiveRecord::Base
 
  REQ_STATUS = %w[PENDING ACCEPTED IGNORED]
  RELATIONS  = %w[ADMIN CPR PR PRJ FRIENDSHIP]

  belongs_to :user
  has_one :sender, :as => :user, :foreign_key => :user_id
  
# has_one :target, :as => :user, :foreign_key => :target_id
 
  before_create :generate_token
  after_create :send_request
  validate :presence, :user_id
  validates :status,  :relation, :presence => true
  validates :status, :inclusion => { :in => REQ_STATUS }
  validates :relation, :inclusion => { :in => RELATIONS }
  attr_accessible :target_id,:user_id,:status,:relation

  #validates_format_of :target_email, :with =>/^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,:allow_blank => false

  def gen_notification
    Update.create(:sender_id=>self.user_id,:target_id=>self.target_id,:reason=>"Request of Connection")
  end
 
  def send_request
    begin  
     UserMailer.send_request(self.user_id,self.target_email,self.id,self.token).deliver
     rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
  end

  private
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
 
end
