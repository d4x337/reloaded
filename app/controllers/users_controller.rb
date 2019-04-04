require 'mime/types'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :crop]
  before_filter :authenticate_user!,except: [:show,:home]
  THUMB_SIZE = 150 
  #layout 'dashboard'
  layout :resolve_layout
  respond_to :html
               
  def index
    if current_user.role? :admin
      if params[:approved] == "false"
        @users = User.find_all_by_approved(false)
      else
        @users = User.all
      end
      respond_to do |format|
        format.html
        format.json  { render :json => @users }
      end
    else

    end
  end

  def profile

  end
  
  def download
    Carrierwave::EncrypterDecrypter::Downloader.decrypt(@user,mounted_as: :avatar)
    file_path = @user.avatar.path
      File.open(file_path, 'r') do |f|
        send_data f.read, type: MIME::Types.type_for(file_path).first.content_type,:filename => File.basename(file_path)
    end
    File.unlink(file_path)
  end

  def complete
    @user = User.find(params[:id])
    respond_to do |format| 
      format.html 
      format.json  { render :json => @users }
    end
  end

  def checknick
    if params[:nickname].blank?
      render :json => [false]
      return
    else
      nickname = params[:nickname]
    end
    
    @user = User.find(:first,:conditions => [ "lower(nickname) = ?",nickname.downcase])
    if @user.blank?
      render :json => [true]
    else
      render :json => [false]
    end
  end
  
  def checkemail
    if params[:email].blank?
      render :json => [false]
      return
    else
      email = params[:email]
    end
    
    @user = User.find(:first,:conditions => [ "lower(email) = ?",email.downcase])
    if @user.blank?
      render :json => [true]
    else
      render :json => [false]
    end
  end

  def show
    @user  = User.find(params[:id]) || User.find_by_nickname(params[:nickname])

  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @user }
    end
  end

  def edit
    if current_user.id == params[:id] or current_user.role? :admin
       @user = User.find(params[:id])
    end
  end
  
  def home
    @user = User.find_by_nickname("d4x337")
    current_user = @user
  end
  
  def picture
    @user = User.find(current_user.id)
  end
  
  def background
    @user = User.find(current_user.id)
  end
  
  def settings
   @user = User.find(current_user.id)
  end

  def set_backgroundOLD
    @user = User.find(current_user.id)
    @user.background=params[:background]
    @user.update_attributes(params[:user])
  end

  def set_background
    @user = User.find(current_user.id)
    @user.background = params['background_id']
    if @user.save
      respond_to do |format|
        format.html
        format.json  { render :json => 'OK' }
      end
    end
  end

  def visitors
    # Visitor.find(:all,:conditions =>['created_at < ?',10.minutes.ago]).each do |visitor| visitor.update_attributes(:deleted=>true) end
    #@visitors = Visitor.where(:deleted=>false).order(:created_at).reverse_order.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @visitors }
    end
  end


  def update

   @user = User.find(current_user.id)
   if @user.update_attributes(params[:user])
      if params[:user][:avatar].blank?
        redirect_to @user
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
  
  def crop
    @user = User.find(params[:id])
    @user.update_attributes(crop_params)
    @user.avatar.reprocess!  #crop the image and then save it.
    redirect_to user_path(@user.id)
  end


  def destroy
    if current_user.id == params[:id] or current_user.role? :admin
      @user = User.find(params[:id])  
      @user.destroy
      respond_to do |format|
        format.html { redirect_to("/") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
         format.html { redirect_to(request.referer, :error => t('permission denied')) }
         format.json { head :no_content }
      end
    end
  end

  private
  def set_user
   # @user = User.find(params[:id])
    @user = User.find_by_nickname(params[:nickname])
  end
  
  def user_params
    params.fetch(:user,{}).permit(:utf8, :_method, :authenticity_token, :commit, :invitation_token, :invite_email,:email_privacy,:status_privacy,:picture_privacy,:last_access_privacy,:global_search_privacy,
     :picture_privacy,:id,:company, :firstname, :nickname,:fullname, :roles,:username, :email, :password, :password_confirmation,:country,:state,:background_id,
     :birthday, :mobile,:roles_mask, :avatar,:country,:locale,roles: [])
  end
  
  def crop_params
    params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end
 
  def resolve_layout
    case action_name
    when "new", "create","crop","update"
      "social"
    when "home"
        "home"
    when "show","profile","edit"
      "profile"
    when "index"
      "dashboard"
    else
      "social"
    end
  end
  
end