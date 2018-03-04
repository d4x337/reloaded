class Api::V1::ContactsController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_contact, :except => [:index, :create]
  before_action :doorkeeper_authorize! # Require access token for all actions
  
  def fetch_contact
    @contact = Contact.find_by_id(params[:id])
  end

  def index
    @contacts = Contact.all
    respond_to do |format|
      format.json { render json: @contacts }
      format.xml { render xml: @contacts }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @contact }
      format.xml { render xml: @contact }
    end
  end

  def create
    @contact = Contact.new(params[:contact])
  
    respond_to do |format|
      if @contact.save
        format.json { render json: @contact, status: :created }
        format.xml { render xml: @contact, status: :created }
      else
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.xml { render xml: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.xml { render xml: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @contact.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.xml { render xml: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
end