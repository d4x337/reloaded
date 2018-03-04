class PhoneNumber < ActiveRecord::Base

  def generate_pin
    self.pin = rand(0000000..9999999).to_s.rjust(7, "0")
    save
  end

  def verify(entered_pin)
    puts "----------------"
    puts "Entered PIN :"+entered_pin
    puts "Stored  PIN :"+self.pin
    puts "----------------"
    if self.pin == entered_pin
       update(verified: true) if self.pin == entered_pin
       return true
     else
       @user = User.find(self.user_id) if self.user_id.present?
       #session.clear
       return false
     end
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
  
  def send_pin
    puts "Your PIN is #{pin}"
    begin  
      UserMailer.send_pin(self.user_id,self.pin).deliver
    rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
  end
  
end

