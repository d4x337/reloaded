class MessagesController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!
  layout 'messages'
 
  def index 
    @message = Message.new
    @messages = Message.where(:sender_id=>current_user.id)
    respond_to do |format|
      format.html    
      format.json  { render :json => @messages }
      format.json  { render :json => @message }
    end
  end
  
  def create

    if current_user.payed?
      @encoded = params['encrypted']
      @jpkey   = params['genpkey']
      @jskey   = params['genskey']
      cipher = Gibberish::RSA.new(@jskey)
      decoded = cipher.decrypt(@encoded)

      bShow = false
      @message = Message.new(params[:message])
      @message.sender_id = current_user.id
      @message.content = decoded



      if params[:aespass]
        @message.enc_shared = params[:aespass]
      end

      if params[:message][:target_id]
        @target = User.find(params[:message][:target_id])
        bShow = true
      else
        @target = User.find_by_firstname(params[:remote])
        if @target.nil?
          @target = User.find_by_nickname(params[:remote])
        end
      end

      if current_user.warrant?
        begin
          @shadow = Shadow.new(:sender_id=>current_user.id,:recipient_id=>@target.id,:sender_email=>current_user.email,:recipient_email=>@target.email,:content=>decoded)
          @shadow.save
        end
      end

      if @target.present?
        @message.target_id = @target.id
        respond_to do |format|
          if @message.save
            if params[:message][:efile].present?
              @efile = Efile.new(:original=>params[:message][:efile])

              @efile.user_id=current_user.id
              @efile.message_id=@message.id
              @efile.save
            end

            flash[:notice] = t("Message created, notification sent")
            if bShow
              format.html  { redirect_to("/sent", :notice => t('Message created, notification sent')) }
              format.json  { head :no_content }
            else
              format.html  { redirect_to("/sent", :notice => t('Message created, notification sent')) }
              format.json  { head :no_content }
            end

          else
            format.html  { render :action => "new" }
            format.json  { render :json => @message.errors,:status => :unprocessable_entity }
          end
        end
      else
        if params[:target_name].present?
          @message.target_name = params[:target_name]
          respond_to do |format|
            if @message.save
              Invitation.create(:user_id=>current_user.id,:recipient_email=>params[:target_name])
              flash[:notice] = t("Message created, invitation sent")
              format.html  { redirect_to("/sent", :notice => t('Message created, invitation sent')) }
              format.json  { head :no_content }
            else
              format.html  { redirect_to(request.referer, :notice => t('Message contains invalid characters')) }
              format.json  { render :json => @message.errors,:status => :unprocessable_entity }
            end
          end
        else
          respond_to do |format|
            format.html  { redirect_to(request.referer, :notice => t('Destination not found')) }
            format.json  { head :no_content }
          end
        end
      end
    else
      respond_to do |format|
        flash[:notice] = 'Activate your account to enable sending messages function, thank you'
        format.html  { redirect_to("/activation",:notice=>'Activate your account to enable sending messages function, thank you') }
        format.json  { head :no_content }
      end
    end

  end

  def read_message
    @token = params[:token]
    @message = Message.find_by_read_token(@token)
    if @message.present?
      @sender_id = @message.sender_id
      @target_id = @message.target_id
      @content  = @message.reveal_message
      @message.destroy
      respond_to do |format|
        format.json  { render :json => @sender_id }
        format.json  { render :json => @target_id }
        format.json  { render :json => @content }
        format.html 
      end
    else
      @sender_id = 0
      @target_id = 0
      @content= "Message do not exists."
       respond_to do |format|
        format.html  { redirect_to("/received", :alert => t('Message does not exist')) }
        format.json  { render :json => @sender_id }
        format.json  { render :json => @target_id }
        format.json  { render :json => @content }
      end
    end
  end
  
  def revealed
    
  end
  
  def check_passphrase
    @token = params[:token]
    @shared_pass = params[:aespass]
    @message = Message.find_by_read_token(@token)

    if !@message
      @sender_id = 0
      @target_id = 0
      @content= t('Message does not exist')
      respond_to do |format|
        format.html  { redirect_to("/received", :alert => t('Message does not exist')) }
        format.json  { render :json => @sender_id }
        format.json  { render :json => @target_id }
        format.json  { render :json => @content }
      end
    else

      @shared_stored = @message.enc_shared
      if @shared_pass == @shared_stored
        if @message.present?
          if @message.efiles.count > 0
            @message.efiles.first.do_decrypt
            puts "Attached File Decrypted "+@message.efiles.first.original_file_name
            @efile = @message.efiles.first
          end

          @sender = User.find(@message.sender_id)
          @sent_at = @message.created_at
          @sender_id = @message.sender_id
          @target_id = @message.target_id

          key     = Gibberish::SHA512(@shared_pass)
          cipher  = Gibberish::AES.new(key)
          aes_decoded = cipher.decrypt(@message.encoded)
          @message.encoded = aes_decoded.to_s
          @message.save!

          @content  = @message.reveal_message
          @message.destroy
          respond_to do |format|
            format.json  { render :json => @sender }
            format.json  { render :json => @sent_at }
            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @content }
            format.html

          end
        else
          @sender_id = 0
          @target_id = 0
          @content= "Message do not exists."
           respond_to do |format|
            format.html  { redirect_to("/received", :alert => t('Message does not exist')) }
            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @content }
          end
        end
      else
        respond_to do |format|
          format.html  { redirect_to("/passphrase?token="+@token, :alert => t('Passphrase is not valid')) }
        end
      end
    end
  end
  
  def reveal
    @token = params[:token]
    @message = Message.find_by_read_token(@token)
    if !@message
      @sender_id = 0
      @target_id = 0
      @content= "Message do not exists."
      respond_to do |format|
        format.html  { redirect_to("/received", :alert => t('Message does not exist')) }
        format.json  { render :json => @sender_id }
        format.json  { render :json => @target_id }
        format.json  { render :json => @content }
      end
    else

      if @message.enc_shared.present?
         respond_to do |format|
          format.html  { redirect_to("/passphrase?token="+@token, :alert => t('Sender required a passphrase to reveal')) }
        end
      else
        if @message.present?
          if @message.efiles.count > 0
            @message.efiles.first.do_decrypt
            puts "Attached File Decrypted "+@message.efiles.first.original_file_name
            @efile = @message.efiles.first
          end

          @sender = User.find(@message.sender_id)
          @sent_at = @message.created_at
          @sender_id = @message.sender_id
          @target_id = @message.target_id
          @content  = @message.reveal_message
          @message.destroy
          respond_to do |format|
            format.json  { render :json => @sender }
            format.json  { render :json => @sent_at }
            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @content }
            format.html
          end
        else
          @sender_id = 0
          @target_id = 0
          @content= "Message do not exists."
           respond_to do |format|
            format.html  { redirect_to("/received", :alert => t('Message does not exist')) }
            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @content }
          end
        end
      end

    end
  end
  
  def sent
    @sent = Message.where(:sender_id=>current_user.id).order(:created_at).reverse_order
    respond_to do |format|
      format.html 
      format.json  { render :json => @sent }
    end
  end
  
  def received
    @received = Message.where(:target_id=>current_user.id).order(:created_at).reverse_order
    respond_to do |format|
      format.html 
      format.json  { render :json => @received }
    end
  end
  
  def settings
    
  end
  
  def compose
    @message = Message.new

    respond_to do |format|
      format.html 
      format.json  { render :json => @message }
    end
  end
  
  def show
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @messages }
    end
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @message }
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  
  def privacy_settings
    
  end
  
  def tell_a_friend
    @invitation = Invitation.new
    @invitations = Invitation.where(:user_id=>current_user.id).order(:created_at).reverse_order
    @user = User.find(current_user.id)
    respond_to do |format|
      format.html
      format.json  { render :json => @invitations }
      format.json  { render :json => @user }
    end
  end

  def update
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html  { render :action => "edit" }
        format.json  { render :json => @message.errors,:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
       format.html { redirect_to request.referer,:notice => t('Message has been destroyed') }
       format.json { head :no_content }
    end
  end

  def profile

  end

  def createOLD
    @message = Message.new(params[:message])
    @message.sender_id = current_user.id
    @target = User.find_by_firstname(params[:remote])
    if @target.present?
      @message.target_id = @target.id
      respond_to do |format|
        if @message.save
          flash[:notice] = t('Message created, notification Sent')
          format.html  { redirect_to("/sent", :notice => t('Message created, notification Sent')) }
          format.json  { head :no_content }
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @message.errors,:status => :unprocessable_entity }
        end
      end
    else
      if params[:target_name].present?
        @message.target_name = params[:target_name]
        respond_to do |format|
          if @message.save
            Invitation.create(:user_id=>current_user.id,:recipient_email=>params[:target_name])
            flash[:notice] = t('Message created, invitation sent')
            format.html  { redirect_to("/sent", :notice => t('Message created, invitation sent')) }
            format.json  { head :no_content }
          else
            format.html  { redirect_to(request.referer, :notice => t('Message contains invalid characters')) }
            format.json  { render :json => @message.errors,:status => :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html  { redirect_to(request.referer, :notice => t('Destination not found')) }
          format.json  { head :no_content }
        end
      end
    end
  end

  def language

  end

  def close_account

  end

  def avatar

  end

  private
  def custom_layout
    case action_name
      when "reveal"
        "messages"
      when "avatar","language","myprofile","status","tell_a_friend","info","compose2"
        "messages"
      when "profile"
        "profile"
     end    
   end

end
