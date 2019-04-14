class Invoice < ActiveRecord::Base
 
   belongs_to :order
   has_one :user
   after_create :send_invoice
   attr_accessible :user_id, :order_id, :invoice_date, :invoice_year, :email, :quantity, :subscription, :annual, :starts_on, :expires_on, :first_name, :last_name, :address, :zip, :town, :city, :country, :telephone, :total, :ip_address, :only_services, :payed, :delivered

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
