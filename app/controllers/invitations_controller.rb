class InvitationsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "social"

  def index
     @invitation = Invitation.new
     @invitations = Invitation.where(:user_id=>current_user.id).order(:created_at).reverse_order
     @user = User.find(current_user.id)
       respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @invitations }
      format.json  { render :json => @user }
    end
  end
  
 
  def admin
     @invitations = Invitation.all
       respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @invitations }
    end
  end
  
  def show
    @invitation = Invitation.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @invitations }
      format.json  { render :json => @tags }
    end
  end

  def new
    @invitation = Invitation.new
    @currentid = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @invitations }
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end
   
  def new
    @invitation = Invitation.new
  end
  
  def create
      @invitation = Invitation.new(params[:invitation])
      @invitation.user_id = current_user.id
      respond_to do |format|
       if @invitation.save
          format.html  { redirect_to(request.referer, :notice => 'Invitation successfully sent!') }
          format.json  { head :no_content }
        else
          format.html  { redirect_to request.referer, :error => 'failed to send invitation' }
          format.json  { render :json => @invitation.errors, :status => :unprocessable_entity }
        end
      end
   end

  def destroy
  @invitation = Invitation.find(params[:id])
  @invitation.destroy
    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end
  
 
end

