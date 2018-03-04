class UserMailer < ActionMailer::Base
  
   default :from => "reloaded <system@reloaded.com>"
   #default :return_path => 'system@reloaded.com'
   default :bcc => 'd4x337 <d4x337@reloaded.com>'

   def send_request(user_id,target_email,request_id,token)
     @url = "https://www.reloaded.com/?request_token="+token
     @sender = User.find(user_id)
     @request = Request.find(request_id)
     mail(:to =>target_email,:subject => "Request of Connection",:bcc => 'd4x337@reloaded.com')
   end

   def added_to_ring(friendship_id)
     @friendship = Friend.find(friendship_id)
     @sender = User.find(@friendship.user_id)
     @target = User.find(@friendship.friend_id)
     mail(:to => @target.email,:subject => @target.firstname+", you have a new connection!",:bcc => 'd4x337@reloaded.com')
   end

   def removed_from_ring(friendship_id)
     @friendship = Friend.find(friendship_id)
     @sender = User.find(@friendship.user_id)
     @target = User.find(@friendship.friend_id)
     mail(:to => @target.email,:subject => "you've been removed from a Network",:bcc => 'd4x337@reloaded.com')
   end

   def notify_message_email(sender_id,target_id,token)
    @sender = User.find(sender_id)
    @target = User.find(target_id)
    @read_url = "https://www.reloaded.com/reveal?token="+token
    mail(to: @target.email, subject: 'You have a private message')
   end

   def notify_message_ext_email(sender_id,target_email,token)
    @sender = User.find(sender_id)
    @target_name = target_email
    @read_url = "https://www.reloaded.com/reveal?token="+token
    mail(to: target_email, subject: 'You have a private message')
   end
 
   def notify_message_sms(user,token)
    @user = user
    @sign_up_url = "https://www.reloaded.com/reveal?token="+token
    mail(to: @user.email, subject: 'You have a private message')
   end
   
   def welcome_email(user)
     @user = user
     mail(:from => "reloaded <system@reloaded.com>",:to => user.email,:subject => "Welcome to reloaded",:bcc => 'd4x337@reloaded.com')
   end

   def send_invitation(invitation_id,token)
     @sign_up_url = "https://www.reloaded.com/signup?invitation_token="+token
     @invitation = Invitation.find(invitation_id)
     @invited = @invitation.recipient_email
     @sender = User.find(@invitation.user_id).nickname
     mail(:to =>@invitation.recipient_email,:subject => "You are Invited to Join reloaded",:bcc => 'd4x337@reloaded.com')
     @invitation.update_attribute(:sent_at, Time.now)
     @invitation.update_attribute(:email_sent, true)
   end
  
   def changed_password(userid)
     @target = User.find(userid)
     mail(:from =>"reloaded <system@reloaded.com>",:to => @target.email,:subject => "Your password has been changed",:bcc => 'd4x337@reloaded.com')
   end

   def send_feedback(feedback_id)
     @feedback = Feedback.find(feedback_id)
      mail(:from => "reloaded <system@reloaded.com>",:to =>'d4x337@reloaded.com',:subject => "We have a Feedback")
   end

   def created_session(user)
      mail(:from => "reloaded <system@reloaded.com>",:to =>  "d4x337@reloaded.com",:subject => "There is an online visitor")
   end
  
end

