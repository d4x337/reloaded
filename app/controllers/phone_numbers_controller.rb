class PhoneNumbersController < ApplicationController
  
  layout "devise"
  def new
    @phone_number = PhoneNumber.new
  end
  
  def create
    @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number])
    @phone_number.user_id = current_user.id if current_user.id.present?
    @phone_number.generate_pin
    @phone_number.action_type =params[:confirmation_or_auth]
    @phone_number.send_pin
    respond_to do |format|
      format.js # render app/views/phone_numbers/create.js.erb
    end
  end
  
  def verify
    puts "VERIFING "+params[:hidden_phone_number]+"  -PIN: "+params[:pin]
    @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
    if @phone_number.verify(params[:pin]) == true
      if params[:confirmation_or_auth] == "CONFIRMATION"
        puts "RESULT => true"
        @phone_number.verified_at = DateTime.now
        @phone_number.user_id = current_user.id if current_user.present?
        @phone_number.action_type = "CONFIRMATION"
        @phone_number.save!
        current_user.mobile_confirmed_at = DateTime.now
        current_user.save!
      elsif params[:confirmation_or_auth] == "AUTH"
         puts "RESULT => true"
         @phone_number.authenticated = true
         @phone_number.action_type = "AUTH"
         @phone_number.user_id = current_user.id if current_user.present?
         @phone_number.save!
         @user = User.find_by_mobile(@phone_number.phone_number)
         sign_in @user
      end
    else
       if params[:confirmation_or_auth] == "CONFIRMATION"
         @phone_number.action_type = "CONFIRMATION"
         @phone_number.save!
       elsif params[:confirmation_or_auth] == "AUTH"
         @phone_number.action_type = "AUTH"
         @phone_number.save!
       end
       puts "RESULT => false"
       if current_user.present?
         sign_out current_user
       end
    end
    respond_to do |format|
      format.js
    end
  end

  
  
end
