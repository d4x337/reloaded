class NotificationMailer < ActionMailer::Base
 
   default :from => "Reloaded <admin@reloaded.online>"
   default :bcc => 'd4x337r@reloaded.online'

  def new_message(message)
    @message = message
    mail(:subject => "[Reloaded] #{message.subject}")
  end
end
