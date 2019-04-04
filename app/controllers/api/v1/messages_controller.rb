class Api::V1::MessagesController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_message, :except => [:index, :create]
  before_action :doorkeeper_authorize! # Require access token for all actions
  
  def fetch_message
    @message = Message.find_by_id(params[:id])
  end

  def index
    @messages = Message.where(:sender_id=>current_user.id)
    respond_to do |format|
      format.json { render json: @messages }
      format.xml { render xml: @messages }
    end
  end

  def update
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @message.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def sent
    @messages = Message.where(:sender_id=>current_user.id).order(:created_at).reverse_order
    respond_to do |format|
      format.json { render json: @messages }
      format.xml { render xml: @messages }
    end
  end

  def received
    @messages =  Message.where(:target_id=>current_user.id).order(:created_at).reverse_order
    respond_to do |format|
      format.json { render json: @messages }
      format.xml { render xml: @messages }
    end
  end

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save
        format.json { render json: @message, status: :created }
        format.xml { render xml: @message, status: :created }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
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
        format.json { render json: @content, status: :ok }
        format.xml { render xml: @content, status: :ok }
        format.json  { render :json => @sender_id }
        format.json  { render :json => @target_id }
      end
    else
      @sender_id = 0
      @target_id = 0
      @content= "Message do not exists."
      respond_to do |format|
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
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
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
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
            format.json { render json: @content, status: :ok }
            format.xml { render xml: @content, status: :ok }

            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @sender }
            format.json  { render :json => @sent_at }
          end
        else
          @sender_id = 0
          @target_id = 0
          @content= "Message do not exists."
          respond_to do |format|
            format.json { render json: @message.errors, status: :unprocessable_entity }
            format.xml { render xml: @message.errors, status: :unprocessable_entity }
          end
        end
      end

    end
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
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.xml { render xml: @message.errors, status: :unprocessable_entity }
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

            format.json { render json: @content, status: :ok }
            format.xml { render xml: @content, status: :ok }

            format.json  { render :json => @sender_id }
            format.json  { render :json => @target_id }
            format.json  { render :json => @sender }
            format.json  { render :json => @sent_at }

          end
        else
          @sender_id = 0
          @target_id = 0
          @content= "Message do not exists."
          respond_to do |format|

            format.json { render json: @message.errors, status: :unprocessable_entity }
            format.xml { render xml: @message.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html  { redirect_to("/passphrase?token="+@token, :alert => t('Passphrase is not valid')) }
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @message }
      format.xml { render xml: @message }
    end
  end


end