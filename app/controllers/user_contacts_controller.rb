class UserContactsController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!
  layout 'social'

  def index
    @user_contact = UserContact.all
    respond_to do |format|
      format.html
      format.json  { render :json => @user_contact }
    end
  end

  def show
    @user_contact = UserContact.find(params[:id])
    respond_to do |format|
      format.html
      format.json  { render :json => @user_contact }
    end
  end

  def new
    @user_contact = UserContact.new
    respond_to do |format|
      format.html
      format.json  { render :json => @user_contact }
    end
  end

  def edit
    @user_contact = UserContact.find(params[:id])
  end

  def create
    @user_contact = UserContact.new(params[:user_contact])
    respond_to do |format|
      if @user_contact.save
        format.html  { redirect_to(request.referer,:notice => 'Contact added successfully') }
        format.json  { render :json => @user_contact,:status => :created, :location => @user_contact }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @user_contact.errors,:status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @user_contact = UserContact.find(params[:id])
    respond_to do |format|
      if @user_contact.update_attributes(params[:user_contact])
        format.html  { redirect_to(:user_contacts_url, :notice => 'Contact updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @user_contact.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_contact = UserContact.find(params[:id])
    @user_contact.destroy

    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end
  
   
end