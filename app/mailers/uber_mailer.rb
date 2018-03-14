class UberMailer < ActionMailer::Base

  SMTP_SETTINGS = {
      :address              => "www.reloaded.online",
      :port                 => 465,
      :domain               => "reloaded.online",
      :authentication       => :plain,
      :enable_starttls_auto => false,
      :ssl                  => true,
      :openssl_verify_mode => "none"
    #:user_name => "custom_account@transfs.com",
    #:password => 'password',
  }

  def custom_email(user_id,bidder, options={})
     xuser=User.find(user_id)
     username = xuser.mail_accounts.first.login
     xpassword  = xuser.mail.accounts.first.password
     
     with_custom_smtp_settings do
        user_name = xuser.mail_accounts.first.login
        password  = xuser.mail.accounts.first.password
        from = xuser.mail_accounts.first.login
     end
  end

  # Override the deliver! method so that we can reset our custom smtp server settings
  def deliver!(mail = @mail)
    out = super
    reset_smtp_settings if @_temp_smtp_settings
    out
  end

  private

  def with_custom_smtp_settings(&block)
    @_temp_smtp_settings = @@smtp_settings
    @@smtp_settings = SMTP_SETTINGS
    yield
  end

  def reset_smtp_settings
    @@smtp_settings = @_temp_smtp_settings
    @_temp_smtp_settings = nil
  end
end