class Invoice < ActiveRecord::Base
 
   belongs_to :order
   
   has_one :user
 
   after_create :send_invoice



   private
   def send_invitation
    begin  
      UserMailer.send_invoice(self.id).deliver
    rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
   end
  
end
