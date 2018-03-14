class NotificationMailer < ActionMailer::Base
 
   default :from => "Reloaded <system@reloaded.online>"
   default :bcc => 'monitor@reloaded.tech'

  def new_message(message)
    @message = message
    mail(:subject => "[Reloaded] #{message.subject}")
  end
end
