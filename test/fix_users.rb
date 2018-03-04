require "rubygems"
require "selenium/client"
require "test/unit"
require 'i18n'
require 'ActiveRecord'

class FixUsers <  ActiveRecord::Base
  
      ActiveRecord::Base.establish_connection(
        Rails.configuration.database_configuration[Rails.env]
      )
    
      r = Random.new
      @users = User.where("confirmed_at is NULL or = ''")
      puts @users.count.to_s
      
      @users.each do |user|
        
        puts user.nickname
        
        user.confirmed_at       = Time.now
 #       user.current_sign_in_ip = "37.23.13.220"
 #       user.last_sign_in_ip    = "37.23.13.220"
        user.last_seen          = Time.now
        user.current_signin_at  = Time.now
        user.last_signin_at     = Time.now
        user.sign_in_count      = r.rand(1...100)
        user.failed_attempts    = r.rand(0...8)
        
        user.save!
      end  
  
  
end