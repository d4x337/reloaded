class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :null_session
 
  CUSTOM_ENTRIES = %w[rsquo lsquo lt gt %22 %20]

  #filter_parameter_logging :card_number, :card_verification
  before_filter :set_locale,:define_current_user,:set_request_format
  after_filter :user_activity,:set_last_seen

  def after_token_authentication
    if params[:authentication_key].present?
      @user = User.find_by_authentication_token(params[:authentication_key]) # we are finding 
      if @user
        sign_in @user  
      else
        redirect_to "/"
      end
    end
  end
  
  private
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else  
      request.user_agent=~ /Mobile|WebOS/
    end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
 
  def user_activity
    current_user.try :touch
  end

  def set_last_seen
    if user_signed_in?
      #not esecute if it's a delete user action FIX!!!!
      @user = User.find(current_user.id)
      @user.last_seen = DateTime.now
      @user.save
    end
  end
  
  def define_current_user
    User.current_user = current_user
  end

  def log_visitor
  
    @client_ip = request.remote_ip
    @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    @my_ip     = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_addr
    @ip_addr   = request.env['REMOTE_ADDR']
    @user_agent= request.env['HTTP_USER_AGENT']
    
    if current_user != nil
      @userid=current_user.id
      @nick=current_user.nickname
    else
      @userid=0
      @nick="guest!"
    end
    
    Visitor.create(:session_id=>session[:session_id],:nickname=>@nick,:headers=>request.headers.to_s,:user_agent=>@user_agent,:remote_ip=>@ip_addr,:user_id=>@userid,
     :referer=>request.env["HTTP_REFERER"],:method=>request.env["REQUEST_METHOD"],:visited_url=>request.env["REQUEST_URI"],
     :remote_host=>request.env["REMOTE_HOST"],:http_accept=>request.env["HTTP_ACCEPT"],:query_string=>request.env["QUERY_STRING"],
     :cookie_string=>request.env["HTTP_COOKIE"])   

  end
  
  helper ApplicationHelper  

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    #redirect_to request.referer
    redirect_to root_url
  end

  rescue_from ActionController::RoutingError, :with => :render_404


  def set_request_format
    if (devise_controller? && action_name == 'create' && request.method == ('POST'))
      request.format = :html
    end
  end


  private
  def render_404(exception = nil)
    if exception
        logger.info "Rendering 404: #{exception.message}"
    end
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def set_locale
    if current_user
      if current_user.locale != nil
         I18n.locale = current_user.locale
      else
          I18n.locale = d4x_sanitizer(params[:locale])
      end
    else
        if params[:locale].present?
            I18n.locale = d4x_sanitizer(params[:locale])
        else
            I18n.locale = extract_locale_from_accept_language_header
        end
    end
  end
  
  def d4x_sanitizer(xobject)
    if xobject.class == Hash
        xobject.each do |key,value|
          if not value.blank?
            value = Sanitize.clean(value, Sanitize::Config::RESTRICTED)
            value = ActionController::Base.helpers.sanitize(value)
            #  CUSTOM_ENTRIES.each do |entry|
            #    if value.include? entry
            #
            #      end 
            #   end
           end   
        end
    elsif xobject.class == String
        xobject = Sanitize.clean(xobject, Sanitize::Config::RESTRICTED)
        xobject = ActionController::Base.helpers.sanitize(xobject)
        # CUSTOM_ENTRIES.each do |entry|
        #    if xobject.include? entry
        #
        #    end 
        # end
    end
  end

  # Access Current User
  def index
    @things = current_user.things
  end
  
  def default_url_options(options={})
      {:locale => I18n.locale}
  end
  
  
  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE'].present?
       case request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
       when 'it'
         'it'
       when 'en'
         'en'
       when 'nl'
         'nl'
       when 'fr'
         'fr'
       when 'de'
         'de'
       when 'pt'
         'pt'
       when 'es'
         'es'
       when 'de'
         'de'
       when 'ru'
         'ru'
       when 'cn'
         'cn'
       when 'se'
         'se'
       else 
         'en'  
       end
    else
       'en'  
    end
  end
  
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Use Devise.secure_compare to compare the access_token  in the database with the access_token given in the params.
    if user && Devise.secure_compare(user.access_token, params[:access_token])

      # Passing store false, will not store the user in the session,
      # so an access_token is needed for every request.
      # If you want the access_token to work as a sign in token,
      # you can simply remove store: false.
      sign_in user, store: false
    end
  end
  
  


end


