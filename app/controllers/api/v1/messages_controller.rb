class Api::V1::MessagesController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_message, :except => [:index, :create]
  before_action :doorkeeper_authorize! # Require access token for all actions
  
  def fetch_message
    @message = Message.find_by_id(params[:id])
  end

  def index
    @messages = Message.all
    respond_to do |format|
      format.json { render json: @messages }
      format.xml { render xml: @messages }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @message }
      format.xml { render xml: @message }
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
end