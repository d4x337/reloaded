class MailAccount < ActiveRecord::Base
  
  belongs_to :user,:foreign_key=>:user_id
 
  attr_accessible :name,:login,:password,:maildir,:home,:quota,:uid,:gid,:tip,:user_id,:defaultbox,:active
 
 # after_create :send_configuration
 
  validates_uniqueness_of :login
 
 ## validates :login ,:presence => true, :length => { :in => 8..100 },
 ##         :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "this is not a valid address" }
          
 ## validates_format_of :login, :with =>/^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,:message => 'this is not a valid address',:allow_blank => false
  
  #validates :name ,:presence => true, :length => { :in => 3..50 },:format => { :with => /\A[a-zA-Z]+\z/,   :message => "Only letters allowed for first name" }
          
##  validates_format_of :password, 
 ##             :with => /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*$/, 
 ##             :message => "must be at least 8 characters, have one number, one capital letter and a special char",
 ##             :if => Proc.new { |mail_account| !mail_account.password.blank? }
              
   def send_configuration
    begin  
      UserMailer.send_configuration(self.user_id,self.login,self.name).deliver
    rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
   end
  
end
