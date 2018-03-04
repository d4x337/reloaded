class AgadangaController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]
  require 'mail'
  #layout :resolve_layout
  layout 'email'

  def agadanga_inbox

    folder = params[:folder]
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first

    if not from.blank?
      require 'will_paginate/array'
      @maildir   = Maildir.new(from.home+"/"+from.maildir,false)
      @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
      @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
      @archivedir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
      @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
      @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)

      @tot_new   = @maildir.list(:new).count
      @tot_inbox = @maildir.list(:cur).count
      @tot_sent  = @sentdir.list(:cur).count
      @tot_spam  = @spamdir.list(:cur).count
      @tot_archivied= @archivedir.list(:cur).count
      @tot_outbox= @maildir.list(:tmp).count
      @tot_draft = @draftdir.list(:cur).count
      @tot_trash = @trashdir.list(:cur).count
      @tot_important = @maildir.list(:cur,:flags=>'F').count
      @tot_new   = @maildir.list(:new).count

      if @tot_new == 0
        xalert = t("There are No New Messages on")+from.login
      elsif @tot_new == 1
        xalert = t("You have 1 New Message on")+from.login
      else
        xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
      end

      @foldername   = 'inbox'

      @folder_new   = @maildir.list(:new)
      @folder_inbox = @maildir.list(:cur)
      @folder       = @folder_new + @folder_inbox
      @folder       = @folder.paginate(:page => params[:page])

      if (@tot_new + @tot_inbox) == 0
        @status = "Inbox Folder is Empty"
      end

    else
      respond_to do |format|
        format.html { redirect_to(request.referer, :alert => t('select an account before continuing')) }
        format.json  { head :ok }
      end
    end
  end

  def agadanga_drafts
   
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if not from.blank?
         require 'will_paginate/array'
         
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
 
         @tot_inbox = @maildir.list(:cur).count
         @tot_archivied=@archivedir.list(:cur).count
         @tot_sent  = @sentdir.list(:cur).count
         @tot_new   = @maildir.list(:new).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
     
         @tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
     
         @folder   = @draftdir.list(:cur).paginate(:page => params[:page])
  
         @foldername   = 'drafts'
    else
         respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t('Select an Account first')) }
           format.json  { head :ok }
         end
    end 
 end

  def agadanga_sent
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if not from.blank?
         require 'will_paginate/array'
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
 
         @tot_new   = @maildir.list(:new).count
         @tot_inbox = @maildir.list(:cur).count
        
         @tot_archivied= @archivedir.list(:cur).count
         @tot_sent  = @sentdir.list(:cur).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
         
         #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
     
         @folder   = @sentdir.list(:cur).paginate(:page => params[:page])
         @foldername   = 'sent'
    else
         respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t('Select an Account first')) }
           format.json  { head :ok }
         end
    end 
 end

  def actions
    
      if (params[:send])
         agadanga_send
         return
      end
    
      if (params[:discard])
         agadanga_discard
         return
      end
    
      if (params[:savedraft])
         agadanga_save_draft
         return    
      end
  
      if (params[:reply])
         agadanga_reply
         return    
      end
  
      if (params[:replyall])
         agadanga_reply_all
         return    
      end
  
      if (params[:forward])
         agadanga_forward
         return    
      end
 
      if (params[:junk])
         agadanga_bigbutton_set_junk
         return    
      end
 
      if (params['junk.x'])
         agadanga_bigbutton_set_junk
         return    
      end
    
      if (params[:delete])
         agadanga_bigbutton_delete
         return    
      end

      if (params['delete.x'])
         agadanga_bigbutton_delete
         return    
      end
    
      if (params[:archive])
         agadanga_bigbutton_archive
         return    
      end

      if (params['archive.x'])
         agadanga_bigbutton_archive
         return    
      end

      if (params[:flag])
         agadanga_bigbutton_mark_important
         return    
      end

      if (params['flag.x'])
         agadanga_bigbutton_mark_important
         return    
      end
 
 
    
      @folder = params['folder']
      @messages = params[:messages]
         if @messages 
           if params[:uberactions].first == "1"                     # Delete selected
              @messages = params[:messages][:key]
              move_to_trash(@folder,@messages)
           
           elsif params[:uberactions].first == "2"                  # Mark selected as Unread
              @messages = params[:messages][:key]
              set_unread(@folder,@messages)
           
           elsif params[:uberactions].first == "3"                  # Mark selected as Read
              @messages = params[:messages][:key]
              set_seen(@folder,@messages)
           
           elsif params[:uberactions].first == "4"                  # Mark selected as Starred
              @messages = params[:messages][:key]
              set_starred(@folder,@messages)
           
           elsif params[:uberactions].first == "5"                  # Mark selected as Starred
              @messages = params[:messages][:key]
              remove_starred(@folder,@messages)
           
           elsif params[:uberactions].first == "8"                  # Copy to Folder
              @messages = params[:messages][:key]
              @dest_folder = params[:dest_folder]
              copy_to_folder
           
           elsif params[:uberactions].first == "9"                  # Move to Folder
              @messages = params[:messages][:key]
              @dest_folder = params[:dest_folder]
              move_to_folder
     
           elsif params[:uberactions].first == "ZIP"                  # ZIP! - (Move to folder Archive)
              @messages = params[:messages][:key]
              agadanga_archive(@folder,@messages)
           
           elsif params[:uberactions].first == "JK"                  # Mark as Junk (Move to Folder Spam)
              @messages = params[:messages][:key]
              agadanga_move_junk(@folder,@messages)
           
           elsif params[:uberactions].first == "DD"                 # Destroy Selected
              @messages = params[:messages][:key]
              destroy_selected(@folder,@messages)
           
           else
              respond_to do |format|
                format.html  { redirect_to(request.referer, :notice => t('unknown action')) }
                format.json  { head :ok }
              end     
           end 
         elsif params[:uberactions].first == "6"                  # Mark folder Read
            make_folder_read(@folder)
         elsif params[:uberactions].first == "7"                  # Mark folder Unread
            make_folder_unread(@folder)
         else
             respond_to do |format|
               format.html  { redirect_to(request.referer,:alert =>t("Select Messages to Process!")) }
               format.json  { head :ok }
            end     
         end
  end
 
  def change
      @account_id = params['account_id']
      MailAccount.where(:user_id=>current_user.id.to_s).update_all(:defaultbox=>false)
      @mail_account = MailAccount.find(@account_id)
      @mail_account.defaultbox = true;
      @mail_account.save
      render :json => {:fromname=>@mail_account.name,:fromaddress=>@mail_account.login}
  end

  def agadanga_view_message
    @message_id = params[:key]
    @folder = params[:folder]
    if not params[:message_id].blank?
      
    end
  end

  def agadanga_restore_message
    @message_id = params[:key]
    @folder = params[:folder]
    if not params[:message_id].blank?
      
    end
  end

  def agadanga_reply_message
    @message_id = params[:key]
    @folder = params[:folder]
    if not params[:message_id].blank?
      
    end
  end

  def agadanga_forward_message
    @message_id = params[:key]
    @folder = params[:folder]
    if not params[:message_id].blank?
      
    end
  end

  def agadanga_set_seen_single_message
    @message_id = params[:key]
    @folder = params[:folder]
    if not params[:message_id].blank?
      
    end

  end

  def agadanga_send

         mail = Mail.new
         
         @from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
         email_with_name = "#{@from.name} <#{@from.login}>"
         
         mail.headers['X-Agadangamail'] = '1.3.37'
         
         if params[:reply_message].present?
            @reply_message_id = params[:reply_message]
            mail.headers['In-Reply-To'] = @reply_message_id
          end
          
         mail.from = email_with_name
         #mail.from = from
         
         if not params[:to].blank?
            mail.to = params[:to]
         end
       
         if not params[:cc].blank?
           mail.cc = params[:cc]
         end 
          
         if not params[:bcc].blank?
          mail.bcc = params[:bcc]
         end
         
         if not params[:subject].blank?
          mail.subject = params[:subject]
         end 
     
         if (params["htmlmsg"] == 'on')
              content = params[:message_html]
              mail.html_part do
                content_type  'text/html; charset=UTF-8'
                body  content
              end
         else
              content = params[:message]
              mail.text_part do
                content_type  'text/plain; charset=UTF-8'
                body  content
              end
         end
           
         if not params[:attachment].blank?
           xFile = File.read(params[:attachment].tempfile)
           mail.attachments[params[:attachment].original_filename] = xFile
         end
         
         if not params[:attachment1].blank?
           xFile1 = File.read(params[:attachment1].tempfile)
           mail.attachments[params[:attachment1].original_filename] = xFile1
         end
         
         if not params[:attachment2].blank?
           xFile2 = File.read(params[:attachment2].tempfile)
           mail.attachments[params[:attachment2].original_filename] = xFile2
          end
         
         if not params[:attachment3].blank?
           xFile3 = File.read(params[:attachment3].tempfile)
           mail.attachments[params[:attachment3].original_filename] = xFile3
         end
         
         if not params[:attachment4].blank?
           xFile4 = File.read(params[:attachment4].tempfile)
           mail.attachments[params[:attachment4].original_filename] = xFile4
         end
 
         #require 'digest/md5'
         #enc_pass = Digest::MD5.hexdigest(from.first.password)
          
         mail.delivery_method.settings = {
 #           :user_name            => @from.login, 
 #           :password             => @from.password,
            :address              => "smtp.agadanga.com",
            :port                 => 465,
            :domain               => "agadanga.com",
            :authentication       => :plain,
            :enable_starttls_auto => false,
            :ssl                  => true,
            :openssl_verify_mode => "none"}    
          
         #UberMailer.custom_email(current_user.id).delivery_method.settings.merge!(SMTP_SETTINGS).deliver
         begin
           mail.deliver!
           
           maildir = Maildir.new(@from.home+"/"+@from.maildir+".Sent",false)  
           maildir.serializer = Maildir::Serializer::Mail.new
           
           begin 
             message = maildir.add(mail) # writes an RFC2822 message to disk
             message.process
             respond_to do |format|
                format.html  { redirect_to("/agadanga-sent", :notice => t('Mail Sent Seccessfully')) }
                format.json  { head :ok }
             end
           rescue Exception => e
                respond_to do |format|
                  format.html  { redirect_to(request.referer,:alert =>t("Error while Saving message in Sent Folder ")+e.to_s) }
                  format.json  { head :ok }
                end
           end
    
         rescue Exception => e
           maildir = Maildir.new(@from.home+"/"+@from.maildir+".Drafts",false)  
           maildir.serializer = Maildir::Serializer::Mail.new

           begin
              message = maildir.add(mail)
              message.process
           rescue Exception => hey
              respond_to do |format|
                format.html  { redirect_to(request.referer,:alert =>t("error while sending message")+" "+e.to_s) }
                format.json  { head :ok }
              end
           end
         end
 end
 
  def agadanga_dashboard
  if (current_user.role? :admin) or (current_user.role? :master) 
      
      if current_user.role? :master 
        @role = "Master"
      elsif current_user.role? :admin 
        @role = "Admin"
      elsif current_user.role? :cpr 
        @role = "CPR"
      elsif current_user.role? :pr 
        @role = "PR"
      elsif current_user.role? :prj
        @role = "PRJ"
      end 

      @incarichi_staff = Staff.where(:user_id => current_user.id)
    
      @orders = Order.find(:all,:conditions =>['user_id in (?)',@incarichi_staff.map(&:pr_id).push(current_user.id)])
      
      @tot_orders = 0
      @tot_team_orders = 0
      @tot_agadanga_box = 0
      @orders.each do |order|
        @tot_agadanga_box += order.quantity
        @tot_orders += 1
        @tot_team_orders += order.total
      end
   
      @staff = User.find(:all,:conditions =>['id in (?)',@incarichi_staff.map(&:pr_id)])
  
      @boss = "Davide Gonnella"
    
      @team_count = 2
      @next_target = 111
      @tot_income = ""
      @next_payment = ""
      
      @request = Request.new
      @requests = Request.where(:user_id=>current_user.id).order(:created_at).reverse_order
     
      @invitation = Invitation.new
      @invitations = Invitation.where(:user_id=>current_user.id).order(:created_at).reverse_order
     
      @incomes = Income.where(:user_id=>0).order(:created_at).reverse_order
 
     
  elsif (current_user.role? :pr) or (current_user.role? :prj) or (current_user.role? :cpr) 
      @request = Request.new
      @requests = Request.where(:user_id=>current_user.id).order(:created_at).reverse_order
      @invitation = Invitation.new
      @invitations = Invitation.where(:user_id=>current_user.id).order(:created_at).reverse_order
      @incomes = Income.where(:user_id=>0).order(:created_at).reverse_order
      
      @incarichi_staff = Staff.where(:user_id => current_user.id)
      @orders = Order.find(:all,:conditions =>['user_id in (?)',@incarichi_staff.map(&:pr_id).push(current_user.id)])
      @incarico  = Staff.where(:pr_id => current_user.id)
      @boss  = User.find(@incarico.user_id)
      @incarichi_staff = Staff.where(:user_id => current_user.id)
      @staff = User.find(:all,:conditions =>['id in (?)',@incarichi_staff.map(&:pr_id)])
   else
     respond_to do |format|
      format.html  { redirect_to(request.referer) }
      format.json  { head :ok }
      end
   end
   
 end
 
  def agadanga_orders
   if (current_user.role? :admin) or (current_user.role? :master) or (current_user.role? :pr) or (current_user.role? :prj) or (current_user.role? :cpr) 
      @incarichi_staff = Staff.where(:user_id => current_user.id)
      @orders = Order.find(:all,:conditions =>['user_id in (?)',@incarichi_staff.map(&:pr_id).push(current_user.id)])
   else
     respond_to do |format|
      format.html  { redirect_to(request.referer) }
      format.json  { head :ok }
      end
   end
 end
 
  def agadanga_partners
   if (current_user.role? :admin) or (current_user.role? :master) or (current_user.role? :pr) or (current_user.role? :prj) or (current_user.role? :cpr) 
      @incarico  = Staff.where(:pr_id => current_user.id).first
      if not @incarico.blank?
         @boss  = User.find(@incarico.user_id)
      end
      @incarichi_staff = Staff.where(:user_id => current_user.id)
      @staff = User.find(:all,:conditions =>['id in (?)',@incarichi_staff.map(&:pr_id)])
   else
     respond_to do |format|
      format.html  { redirect_to(request.referer) }
      format.json  { head :ok }
      end
   end
 end
 
  def agadanga_save_draft
    @from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
    maildir = Maildir.new(@from.home+"/"+@from.maildir+".Drafts",false)  
    maildir.serializer = Maildir::Serializer::Mail.new
    mail = Mail.new()
    mail.headers['X-Agadangamail'] = '1.3.37'
        
#    if (params["content_type"] == "html")
#      content_type 'text/html; charset=UTF-8'
#    end 
    mail.from = current_user.email
    mail.to      = params["to"]
    mail.cc      = params["cc"]
    mail.bcc     = params["bcc"]
    mail.subject = params["subject"]
    
   if (params["htmlmsg"] == 'on')
        content = params[:message_html]
        mail.html_part do
          content_type  'text/html; charset=UTF-8'
          body  content
        end
   else
        content = params[:message]
        mail.text_part do
          content_type  'text/plain; charset=UTF-8'
          body  content
        end
   end
         
   if not params[:attachment].blank?
     xFile = File.read(params[:attachment].tempfile)
     mail.attachments[params[:attachment].original_filename] = xFile
   end
         
   if not params[:attachment1].blank?
     xFile1 = File.read(params[:attachment1].tempfile)
     mail.attachments[params[:attachment1].original_filename] = xFile1
   end
   
   if not params[:attachment2].blank?
     xFile2 = File.read(params[:attachment2].tempfile)
     mail.attachments[params[:attachment2].original_filename] = xFile2
    end
   
   if not params[:attachment3].blank?
     xFile3 = File.read(params[:attachment3].tempfile)
     mail.attachments[params[:attachment3].original_filename] = xFile3
   end
   
   if not params[:attachment4].blank?
     xFile4 = File.read(params[:attachment4].tempfile)
     mail.attachments[params[:attachment4].original_filename] = xFile4
   end
 
   begin 
        message = maildir.add(mail) # writes an RFC2822 message to disk
        message.process

        respond_to do |format|
          format.html  { redirect_to("/agadanga-drafts", :notice => t('your message has been saved in draft folder.')) }
          format.json  { head :ok }
        end
     rescue Exception => e
        respond_to do |format|
          format.html  { redirect_to(request.referer, :alert =>e.to_s) }
          format.json  { head :ok }
        end
    end
 end
 
  def agadanga_discard
    respond_to do |format|
        format.html  { redirect_to(request.referer, :notice => t('your message has been discarted.')) }
        format.json  { head :ok }
     end
 end
 
  def show(folder,message_id)
 
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
    
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    elsif folder == 'new'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false)
       @new = @maildir.list(:new)
       @xmsg = @maildir.get(message_id)
       xmail = Mail.new(@xmsg.data)
       xmail.process  
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       @xmsg = @maildir.get(message_id)
       @xmsg.add_flag("S")
    end
   
    respond_to do |format|
      format.html  { redirect_to(request.referer,:notice =>t("Successfully marked as unread")) }
      format.json  { head :ok }
    end

  end

  def agadanga_refresh
    
   
      from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
      folder = params[:folder]     
 
      if not from.blank?
         require 'will_paginate/array'
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
 
         @tot_inbox = @maildir.list(:cur).count
         @tot_archivied= @archivedir.list(:cur).count
         @tot_sent  = @sentdir.list(:cur).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
    
         #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
         
         respond_to do |format|
           format.html { redirect_to(request.referer, :alert => xalert) }
           format.json  { head :ok }
         end
     else    
         respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t("Select an Account to Check")) }
           format.json  { head :ok }
         end
     end 
  end

  def agadanga_compose
     @contacts  = Contact.where(:user_id=>current_user.id)
     from       = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
     @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
     @tot_sent  = @sentdir.list(:cur).count
     @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
     @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
     @archivedir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
     @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
     @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
     @tot_inbox = @maildir.list(:cur).count
     @tot_new   = @maildir.list(:new).count
     @tot_spam  = @spamdir.list(:cur).count
     @tot_archivied= @archivedir.list(:cur).count
     @tot_outbox= @maildir.list(:tmp).count
     @tot_draft = @draftdir.list(:cur).count
     @tot_trash = @trashdir.list(:cur).count
     #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
      @tot_important = @maildir.list(:cur,:flags=>'F').count
      @tot_new   = @maildir.list(:new).count
     if @tot_new == 0
        xalert = t("There are No New Messages on")+from.login
     elsif @tot_new == 1
        xalert = t("You have 1 New Message on")+from.login
     else
        xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
     end
  
   end
 
  def agadanga_reply
     if not params[:folder].blank? and not params[:message_id].blank?
        from       = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        message_id = params[:messages_id]
        folder     = params[:folder]
 
        if folder == 'inbox'
           @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
           @xmsg = @maildir.get(params[:message_id]) 
        elsif folder == 'sent'
          @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           @xmsg = @sentdir.get(params[:message_id]) 
        elsif folder == 'drafts'
           @draftdir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           @xmsg = @draftdir.get(params[:message_id]) 
        elsif folder == 'archive'
           @archivedir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
           @xmsg = @archivedir.get(params[:message_id]) 
        elsif folder == 'spam'
           @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
           @xmsg = @spamdir.get(params[:message_id]) 
        elsif folder == 'trash'
           @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           @xmsg = @trashdir.get(params[:message_id]) 
        end 

        xmail = Mail.new(@xmsg.data)   

        @to = xmail.from
        @subject = "RE:"+xmail.subject
        @from = current_user.email
        @message_id = xmail.message_id
        @action = "reply"

        #set mail.headers['In-Reply-To'] = xmail.message_id
        respond_to do |format|
          format.html  { redirect_to(request.referer) }
          format.json  { render :json => @to }
          format.json  { render :json => folder }
          format.json  { render :json => @message_id }
          format.json  { render :json => @from }
          format.json  { render :json => @subject }
          format.json  { render :json => @action }
        end
     
     else
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select a Message to Reply!")) }
         format.json  { head :ok }
        end
     end  
  end

  def agadanga_reply_all
     if not params[:folder].blank? and not params[:message_id].blank?
        
        from       = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
         message_id = params[:messages_id]
        folder = params[:folder]
      
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
        end 
        @xmsg = @maildir.get(message_id)
        xmail = Mail.new(@xmsg.data)   

        @to = xmail.from
        @subject = "RE:"+xmail.subject
        @from = current_user.email
        respond_to do |format|
          format.html  { render "agadanga/agadanga_reply_all",:notice =>"Reply All "+@to }
          format.json  { render :json => @to }
          format.json  { render :json => @from }
          format.json  { render :json => @subject }
        end
     else
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select a Message to Reply All")) }
         format.json  { head :ok }
        end
     end  
  end

  def agadanga_forward
     if not params[:folder].blank? and not params[:message_id].blank?
        
        from       = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        message_id = params[:messages_id]
        folder = params[:folder]
      
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
        end 
        @xmsg = @maildir.get(message_id)
        xmail = Mail.new(@xmsg.data)   

        @to = xmail.from
        @subject = "FW:"+xmail.subject
        @from = current_user.email
        respond_to do |format|
          format.html  { render "agadanga/agadanga_forward",:notice =>"Forward to "+@to }
          format.json  { render :json => @to }
          format.json  { render :json => @from }
          format.json  { render :json => @subject }
        end
     else
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select a Message to Forward")) }
         format.json  { head :ok }
        end
     end  
  end

  def agadanga_junk
    folder = params[:folder]     
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if not from.blank?
         require 'will_paginate/array'
       
         @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @tot_sent  = @sentdir.list(:cur).count

         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @tot_inbox = @maildir.list(:cur).count

         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @tot_draft = @draftdir.list(:cur).count

         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @tot_archivied= @archivedir.list(:cur).count

         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @tot_trash = @trashdir.list(:cur).count

         @tot_new   = @maildir.list(:new).count
         @tot_outbox= @maildir.list(:tmp).count
         
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
         @tot_spam  = @spamdir.list(:cur).count
   
          #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
     
         @foldername   = 'spam'
         @folder   = @spamdir.list(:cur).paginate(:page => params[:page])
        
         if @tot_spam == 0
             @status = "Junk is Empty"
         end
         
     else
        respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t('select an account before continuing')) }
           format.json  { head :ok }
        end
     end
 end
 
  def agadanga_delete
    if not params[:messages].blank?
        @messages = params[:messages][:key]
        folder = params[:folder]     
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
        end 
      
       begin
          @messages.each do |message|
           @xmsg = @maildir.get(message.key)
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Deleted Messages")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while deleting messages")) }
           format.json  { head :ok }
          end
        end
     else
       
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to Delete")) }
         format.json  { head :ok }
        end
     end  
  end

  def agadanga_move_junk(folder,messages)
    if not messages.blank?
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
           sourcedir= from.home+"/"+from.maildir
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           sourcedir= from.home+"/"+from.maildir+".Sent"
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           sourcedir= from.home+"/"+from.maildir+".Drafts"
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           sourcedir= from.home+"/"+from.maildir+".Trash"
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
           sourcedir= from.home+"/"+from.maildir+".Archive"
        end 
      
        @trashdir= Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        targetdir = from.home+"/"+from.maildir+".Spam"
      
       begin
          messages.each do |key|
           key["999"] = ","
           @xmsg = @maildir.get(revert_key(key))
           sourcefile = sourcedir+"/"+key
           targetfile = targetdir+"/"+key
           FileUtils.cp sourcefile,targetfile
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Moved Messages to Junk!")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Junk ")+e.to_s) }
           format.json  { head :ok }
          end
        end
     else
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to set Junk")) }
         format.json  { head :ok }
        end
     end  
 end

  def agadanga_bigbutton_delete
    begin
       folder = params['folder']
       @messages = params[:messages][:key]
       from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
       if folder == 'inbox'
          @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
       elsif folder == 'sent'
          @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       elsif folder == 'drafts'
          @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       elsif folder == 'archive'
          @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       elsif folder == 'spam'
          @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       elsif folder == 'trash'
          @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       end 
          
       begin
          @messages.each do |message|
           @xmsg = @maildir.get(revert_key(message))
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Deleted Messages")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while deleting messages")) }
           format.json  { head :ok }
          end
        end
     rescue
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to Delete")) }
         format.json  { head :ok }
        end
     end  
  end

  def agadanga_bigbutton_set_junk
    begin
        folder = params['folder']
        @messages = params[:messages][:key]
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
           sourcedir= from.home+"/"+from.maildir
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           sourcedir= from.home+"/"+from.maildir+".Sent"
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           sourcedir= from.home+"/"+from.maildir+".Drafts"
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           sourcedir= from.home+"/"+from.maildir+".Trash"
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
           sourcedir= from.home+"/"+from.maildir+".Archive"
        end 
      
        @trashdir= Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        targetdir = from.home+"/"+from.maildir+".Spam"
      
       begin
          @messages.each do |key|
           @xmsg = @maildir.get(revert_key(key))
           sourcefile = sourcedir+"/"+key
           targetfile = targetdir+"/"+key
           FileUtils.cp sourcefile,targetfile
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Moved Messages to Junk!")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Junk ")+e.to_s) }
           format.json  { head :ok }
          end
        end
    rescue
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to set Junk")) }
         format.json  { head :ok }
        end
     end  
 end

  def agadanga_bigbutton_archive
     begin
        folder = params['folder']
        @messages = params[:messages][:key]
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
           sourcedir= from.home+"/"+from.maildir
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           sourcedir= from.home+"/"+from.maildir+".Sent"
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           sourcedir= from.home+"/"+from.maildir+".Drafts"
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           sourcedir= from.home+"/"+from.maildir+".Trash"
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
           sourcedir= from.home+"/"+from.maildir+".Spam"
        end 
      
        @trashdir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        targetdir = from.home+"/"+from.maildir+".Archive"
      
       begin
          @messages.each do |key|
           @xmsg = @maildir.get(revert_key(key))
           sourcefile = sourcedir+"/"+key
           targetfile = targetdir+"/"+key
           FileUtils.cp sourcefile,targetfile
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Moved Messages to Archive")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Archive ")+e.to_s) }
           format.json  { head :ok }
          end
        end
     rescue
        respond_to do |format|
          format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Archive ")+e.to_s) }
          format.json  { head :ok }
        end
     end  

 end

  def agadanga_bigbutton_mark_important
   begin
        folder = params['folder']
        @messages = params[:messages][:key]
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false)
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
        end
     
        begin
          @messages.each do |key|
           @xmsg = @maildir.get(revert_key(key))
           @xmsg.add_flag("F")
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Selected Messages Flagged as Important")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error While Settings Flag Important on Messages ")+e.to_s) }
           format.json  { head :ok }
          end
        end
    rescue
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to Flag as Important!")) }
         format.json  { head :ok }
        end
     end  
 end
 
  def agadanga_archive(folder,messages)
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
           sourcedir= from.home+"/"+from.maildir
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           sourcedir= from.home+"/"+from.maildir+".Sent"
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           sourcedir= from.home+"/"+from.maildir+".Drafts"
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           sourcedir= from.home+"/"+from.maildir+".Trash"
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
           sourcedir= from.home+"/"+from.maildir+".Spam"
        end 
      
        @trashdir= Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        targetdir = from.home+"/"+from.maildir+".Archive"
      
       begin
          messages.each do |key|
           @xmsg = @maildir.get(revert_key(key))
           sourcefile = sourcedir+"/"+key
           targetfile = targetdir+"/"+key
           FileUtils.cp sourcefile,targetfile
           @xmsg.destroy
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Successfully Moved Messages to Archive")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Archive ")+e.to_s) }
           format.json  { head :ok }
          end
        end
   end
 
  def agadanga_flag
    if not params[:messages].blank?
        @messages = params[:messages][:key]
        folder = params[:folder]     
        from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
        if folder == 'inbox'
           @maildir = Maildir.new(from.home+"/"+from.maildir,false)
        elsif folder == 'sent'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
        elsif folder == 'drafts'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
        elsif folder == 'archive'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
        elsif folder == 'trash'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
        elsif folder == 'spam'
           @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
        end
     
        begin
          messages.each do |key|
           @xmsg = @maildir.get(revert_key(key))
           @xmsg.add_flag("F")
          end
          respond_to do |format|
           format.html  { redirect_to(request.referer,:notice =>t("Selected Messages Flagged as Important")) }
           format.json  { head :ok }
          end
    
        rescue Exception => e
          respond_to do |format|
           format.html  { redirect_to(request.referer,:alert =>t("Error While Settings Flag Important on Messages ")+e.to_s) }
           format.json  { head :ok }
          end
        end
     else
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Select Messages to Flag as Important!")) }
         format.json  { head :ok }
        end
     end  
  end
 
  def agadanga_important
     
     from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
     if not from.blank?
           require 'will_paginate/array'
           @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
           @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
           @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
   
           @tot_sent  = @sentdir.list(:cur).count
           @tot_inbox = @maildir.list(:cur).count
           @tot_new   = @maildir.list(:new).count
           @tot_spam  = @spamdir.list(:cur).count
           @tot_archivied= @archivedir.list(:cur).count
           @tot_outbox= @maildir.list(:tmp).count
           @tot_draft = @draftdir.list(:cur).count
           @tot_trash = @trashdir.list(:cur).count
           @tot_new   = @maildir.list(:new).count
           if @tot_new == 0
              xalert = t("There are No New Messages on")+from.login
           elsif @tot_new == 1
              xalert = t("You have 1 New Message on")+from.login
           else
              xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
           end
   
           @important_inbox = @maildir.list(:cur,:flags=>'F').paginate(:page => params[:page])
           @tot_important = @important_inbox.count
           @foldername   = "inbox"
           @folder   = @important_inbox
      else
           respond_to do |format|
             format.html { redirect_to(request.referer, :alert => t('Select an Account first')) }
             format.json  { head :ok }
           end
      end 

 end

  def agadanga_important_evo
     from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
     if not from.blank?
           require 'will_paginate/array'
           @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
           @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
           @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
           @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
           @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
           @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
   
           @tot_sent  = @sentdir.list(:cur).count
           @tot_inbox = @maildir.list(:cur).count
           @tot_new   = @maildir.list(:new).count
           @tot_spam  = @spamdir.list(:cur).count
           @tot_archivied= @archivedir.list(:cur).count
           @tot_outbox= @maildir.list(:tmp).count
           @tot_draft = @draftdir.list(:cur).count
           @tot_trash = @trashdir.list(:cur).count
           @tot_new   = @maildir.list(:new).count
           if @tot_new == 0
              xalert = t("There are No New Messages on")+from.login
           elsif @tot_new == 1
              xalert = t("You have 1 New Message on")+from.login
           else
              xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
           end
   
           @tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
   
           @important_inbox = @maildir.list(:cur,:flags=>'F')
           @important_sent  = @sentdir.list(:cur,:flags=>'F')
           @important_draft = @draftdir.list(:cur,:flags=>'F')
           @important_archivied= @archivedir.list(:cur,:flags=>'F')
           @important_trash = @trashdir.list(:cur,:flags=>'F')
          
           @foldername   = "important"
    
           #add an attribute to @folder list to discriminate when opening since favourites have mixed sources.
                 
           @folder   = @important_inbox+@important_sent+@important_draft+@important_archivied+@important_trash
     
      else
           respond_to do |format|
             format.html { redirect_to(request.referer, :alert => t('Select an Account first')) }
             format.json  { head :ok }
           end
      end 

 end
 
  def agadanga_archivied
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if not from.blank?
         require 'will_paginate/array'
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @sentdir   = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
 
         @tot_inbox = @maildir.list(:cur).count
         @tot_archivied= @archivedir.list(:cur).count
         @tot_sent  = @sentdir.list(:cur).count
         @tot_new   = @maildir.list(:new).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
      #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
            @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
   
         @folder   = @archivedir.list(:cur).paginate(:page => params[:page])
         @foldername = "archive"

    else
         respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t('Select an Account first')) }
           format.json  { head :ok }
         end
    end 
 end
 
  def agadanga_trash
     folder = params[:folder]     
     from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if not from.blank?
         require 'will_paginate/array'
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
         @tot_inbox = @maildir.list(:cur).count
         @tot_sent  = @sentdir.list(:cur).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_archivied= @archivedir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_trash = @trashdir.list(:cur).count
         #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
  
         @folder   = @trashdir.list(:cur).paginate(:page => params[:page])
         @foldername = "trash"
        if @tot_trash == 0
             @status = "Trash is Empty"
         end
     else
        respond_to do |format|
           format.html { redirect_to(request.referer, :alert => t('select an account before continuing')) }
           format.json  { head :ok }
        end
     end
  end
  
  def index
     if current_user
        @mail_account = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
        if @mail_account
          respond_to do |format|
             format.html { redirect_to("/inbox", :alert => t('select an account before continuing')) }
             format.json  { head :ok }
          end
            
        else
          respond_to do |format|
             format.html { redirect_to("/email") }
             format.json  { head :ok }
          end
            
        end
     else
        respond_to do |format|
           format.html { redirect_to("/email") }
           format.json  { head :ok }
        end
     end
  end

  def make_folder_read(folder)

    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
   
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end 
    
    begin
       @messages = @maildir.list(:cur)
       @messages.each do |message|
         @xmsg = @maildir.get(message.key)
         @xmsg.add_flag("S")
       end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Marked Folder")+" "+folder+" "+t("as Read")) }
       format.json  { head :ok }
      end
    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while setting folder read")+" "+e.to_s) }
       format.json  { head :ok }
      end
    end
  end
  
  def make_folder_unread(folder)

   from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
   if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end 
    
     begin
       @messages = @maildir.list(:cur)
       @messages.each do |message|
         @xmsg = @maildir.get(message.key)
         @xmsg.remove_flag("S")
       end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Marked Folder")+" "+folder+" "+t("as UnRead")) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while setting folder unread")+" "+e.to_s) }
       format.json  { head :ok }
      end
    end

  end
  
  def set_starred(folder,messages)
 
   from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
    
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false)
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end
 
    begin
      messages.each do |key|
       @xmsg = @maildir.get(revert_key(key))
       @xmsg.add_flag("F")
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Messages Flagged successfully")) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while setting Flag on messages ")+e.to_s) }
       format.json  { head :ok }
      end
    end
  end

  def remove_starred(folder,messages)
   
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false)
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end
 
    begin
      messages.each do |key|
       @xmsg = @maildir.get(revert_key(key))
       @xmsg.remove_flag("F")
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Successfully Removed Flag Important")) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while removing Flags ")+e.to_s) }
       format.json  { head :ok }
      end
    end
  end
  
  def set_seen(folder,messages)
      from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
   
      if folder == 'inbox'
         @maildir = Maildir.new(from.home+"/"+from.maildir,false)
      elsif folder == 'sent'
         @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
      elsif folder == 'drafts'
         @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
      elsif folder == 'archive'
         @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
      elsif folder == 'trash'
         @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
      elsif folder == 'spam'
         @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
      end
       
      begin
        messages.each do |key|
         @xmsg = @maildir.get(revert_key(key))
         if folder == "new"
            xmail = Mail.new(@xmsg.data)
            xmail.process  
         else
            @xmsg.add_flag("S")
         end
       end
        respond_to do |format|
         format.html  { redirect_to(request.referer,:notice =>"Successfully marked as Read") }
         format.json  { head :ok }
       end
  
      rescue Exception => e
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>"Error while marking as Read "+e.to_s) }
         format.json  { head :ok }
        end
      end
  end
  
  def set_unread(folder,messages)
    
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false)
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end
 
    begin
      messages.each do |key|
       @xmsg = @maildir.get(revert_key(key))
       @xmsg.remove_flag("S")
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>"Successfully marked as unread") }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>"Error while marking as unread "+e.to_s) }
       format.json  { head :ok }
      end
    end
  end

  def move_to_trash(folder,messages)
 
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
  
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
       sourcedir= from.home+"/"+from.maildir
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       sourcedir= from.home+"/"+from.maildir+".Sent"
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       sourcedir= from.home+"/"+from.maildir+".Archive"
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       sourcedir= from.home+"/"+from.maildir+".Drafts"
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       sourcedir= from.home+"/"+from.maildir+".Spam"
    end 
  
    @trashdir= Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    targetdir = from.home+"/"+from.maildir+".Trash"
  
     begin
        messages.each do |key|
         @xmsg = @maildir.get(revert_key(key))
         sourcefile = sourcedir+"/"+key
         targetfile = targetdir+"/"+key
         FileUtils.cp sourcefile,targetfile
         @xmsg.destroy
        end
        respond_to do |format|
         format.html  { redirect_to(request.referer,:notice =>t("Selected Messages Moved to Trash")) }
         format.json  { head :ok }
        end
  
      rescue Exception => e
        respond_to do |format|
         format.html  { redirect_to(request.referer,:alert =>t("Error while moving to Trash ")+e.to_s) }
         format.json  { head :ok }
        end
      end
    
  end
  
  def copy_to_folder
    
    @messages = params[:messages][:key]
    folder = params[:folder]     
    dest_folder = params[:dest_folder]     
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
  
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
       sourcedir= from.home+"/"+from.maildir
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       sourcedir= from.home+"/"+from.maildir+".Sent"
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       sourcedir= from.home+"/"+from.maildir+".Drafts"
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       sourcedir= from.home+"/"+from.maildir+".Archive"
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       sourcedir= from.home+"/"+from.maildir+".Spam"
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       sourcedir= from.home+"/"+from.maildir+".Trash"
    end 

    if dest_folder == 'inbox'
       @destdir = Maildir.new(from.home+"/"+from.maildir,false) 
       targetdir= from.home+"/"+from.maildir
    elsif dest_folder == 'sent'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       targetdir= from.home+"/"+from.maildir+".Sent"
    elsif dest_folder == 'drafts'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       targetdir= from.home+"/"+from.maildir+".Drafts"
    elsif dest_folder == 'archive'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       targetdir= from.home+"/"+from.maildir+".Archive"
    elsif dest_folder == 'spam'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       targetdir= from.home+"/"+from.maildir+".Spam"
    elsif dest_folder == 'trash'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       targetdir= from.home+"/"+from.maildir+".Trash"
    end 
    
   begin
      @messages.each do |key|
       sourcefile = sourcedir+"/"+revert_key(key)
       targetfile = targetdir+"/"+revert_key(key)
       FileUtils.cp sourcefile,targetfile
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Successfully copied messages from ")+folder+ t(" to ")+dest_folder) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while copying messages ")+" "+e.to_s) }
       format.json  { head :ok }
      end
    end
    
  end
  
  def move_to_folder  
    
    @messages = params[:messages][:key]
    folder = params[:folder]     
    dest_folder = params[:dest_folder]     
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
    
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
       sourcedir= from.home+"/"+from.maildir
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       sourcedir= from.home+"/"+from.maildir+".Sent"
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       sourcedir= from.home+"/"+from.maildir+".Drafts"
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
       sourcedir= from.home+"/"+from.maildir+".Archive"
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       sourcedir= from.home+"/"+from.maildir+".Spam"
    elsif folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       sourcedir= from.home+"/"+from.maildir+".Trash"
    end 

    if dest_folder == 'inbox'
       @destdir = Maildir.new(from.home+"/"+from.maildir,false) 
       targetdir= from.home+"/"+from.maildir
    elsif dest_folder == 'sent'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
       targetdir= from.home+"/"+from.maildir+".Sent"
    elsif dest_folder == 'drafts'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
       targetdir= from.home+"/"+from.maildir+".Drafts"
    elsif dest_folder == 'spam'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
       targetdir= from.home+"/"+from.maildir+".Spam"
    elsif dest_folder == 'trash'
       @destdir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
       targetdir= from.home+"/"+from.maildir+".Trash"
    end 

   begin
     @messages.each do |key|
       sourcefile = sourcedir+"/"+revert_key(key)
       targetfile = targetdir+"/"+revert_key(key)
       FileUtils.cp sourcefile,targetfile
       @xmsg.destroy
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Successfully moved messages from")+folder+ t("to")+dest_folder) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while moved messages")+" "+e.to_s) }
       format.json  { head :ok }
      end
    end
    
  end
  
  def agadanga_keys
   from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
   @mail_account = from;
   @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
   @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
   @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
   @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
   @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
   @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
   @tot_sent  = @sentdir.list(:cur).count
   @tot_inbox = @maildir.list(:cur).count
   @tot_new   = @maildir.list(:new).count
   @tot_spam  = @spamdir.list(:cur).count
   @tot_archivied= @archivedir.list(:cur).count
   @tot_outbox= @maildir.list(:tmp).count
   @tot_draft = @draftdir.list(:cur).count
   @tot_trash = @trashdir.list(:cur).count
   #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
   @tot_important = @maildir.list(:cur,:flags=>'F').count
   @tot_new   = @maildir.list(:new).count
   if @tot_new == 0
      xalert = t("There are No New Messages on")+from.login
   elsif @tot_new == 1
      xalert = t("You have 1 New Message on")+from.login
   else
      xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
   end
  
   @mail_account = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
  end

  def move_to_inbox(folder,messages)

    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
 
    if folder == 'trash'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false) 
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'archive'   
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end 
    @inbox= Maildir.new(from.home+"/"+from.maildir,false)
  
   begin
      messages.each do |key|
       @xmsg = @maildir.get(revert_key(key))
       @inbox.add(@xmsg)
       @xmsg.destroy
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Messages Moved to Inbox")) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error while moving messages")+e.to_s) }
       format.json  { head :ok }
      end
    end
  end

  def destroy_selected(folder,messages)

   from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
   if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'archive'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
   end 
  
   begin
      messages.each do |key|
       @xmsg = @maildir.get(revert_key(key))
       @xmsg.destroy
      end
      respond_to do |format|
       format.html  { redirect_to(request.referer,:notice =>t("Successfully Deleted Messages")) }
       format.json  { head :ok }
      end

    rescue Exception => e
      respond_to do |format|
       format.html  { redirect_to(request.referer,:alert =>t("Error While Deleting Messages")+e.to_s) }
       format.json  { head :ok }
      end
    end
  end

  def download_attachment(folder,message_key,file_name)
    from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
    if folder == 'inbox'
       @maildir = Maildir.new(from.home+"/"+from.maildir,false) 
    elsif folder == 'sent'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
    elsif folder == 'drafts'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
    elsif folder == 'trash'   
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
    elsif folder == 'archive'   
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
    elsif folder == 'spam'
       @maildir = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
    end 
     @xmsg = @maildir.get(revert_key(message_key))
     mail = Mail.new(@xmsg.data)
      mail.attachments.each do |xfile|
      if xfile == file_name
          file = StringIO.new(xfile.decoded)
          file.class.class_eval { attr_accessor :original_filename, :content_type}
          file.original_filename = xfile.filename
          file.content_type = xfile.mime_type
                
      end
    end
  
  end

  def agadanga_settings
         from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
         @mail_account = from;
 
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
         @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @tot_sent  = @sentdir.list(:cur).count
         @tot_inbox = @maildir.list(:cur).count
         @tot_new   = @maildir.list(:new).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_archivied= @archivedir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
         #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
         @user = User.find(current_user.id)  
   end
  
  def agadanga_address_book
        
         from = MailAccount.where(:user_id=>current_user.id,:defaultbox=>true).first
         @mail_account = from;
 
         @maildir   = Maildir.new(from.home+"/"+from.maildir,false) 
         @draftdir  = Maildir.new(from.home+"/"+from.maildir+".Drafts",false)
         @archivedir  = Maildir.new(from.home+"/"+from.maildir+".Archive",false)
         @trashdir  = Maildir.new(from.home+"/"+from.maildir+".Trash",false)
         @spamdir   = Maildir.new(from.home+"/"+from.maildir+".Spam",false)
         @sentdir = Maildir.new(from.home+"/"+from.maildir+".Sent",false)
         @tot_sent  = @sentdir.list(:cur).count
         @tot_inbox = @maildir.list(:cur).count
         @tot_new   = @maildir.list(:new).count
         @tot_spam  = @spamdir.list(:cur).count
         @tot_archivied= @archivedir.list(:cur).count
         @tot_outbox= @maildir.list(:tmp).count
         @tot_draft = @draftdir.list(:cur).count
         @tot_trash = @trashdir.list(:cur).count
         #@tot_important = @maildir.list(:cur,:flags=>'F').count+@sentdir.list(:cur,:flags=>'F').count+@draftdir.list(:cur,:flags=>'F').count+@archivedir.list(:cur,:flags=>'F').count+@trashdir.list(:cur,:flags=>'F').count
         @tot_important = @maildir.list(:cur,:flags=>'F').count
         @tot_new   = @maildir.list(:new).count
         if @tot_new == 0
            xalert = t("There are No New Messages on")+from.login
         elsif @tot_new == 1
            xalert = t("You have 1 New Message on")+from.login
         else
            xalert = t("You have")+@tot_new.to_s+ t("New Messages on")+from.login
         end
 
        @contact  = Contact.new
        @contacts = Contact.where(:user_id => current_user.id)
        respond_to do |format|
          format.html
          format.json  { render :json => @contact }
          format.json  { render :json => @contacts }
        end
     end

  def norm_key(message_key)
      #message_key[","] = "999"  -> NOT GOOD, RETURNS EXCEPTION IF NOT FOUND!
      message_key.gsub(",","999")
      
      return message_key
    end
    
  def revert_key(message_key)
      #message_key["999"] = ","
      message_key.gsub("999",",")
      return message_key
    end
    
  private
  def resolve_layout
      case action_name
      when "agadanga_dashboard"
        "webmail"
      when "agadanga_settings"
        "webmail"
      else
        "webmail"
      end    
    end
end


