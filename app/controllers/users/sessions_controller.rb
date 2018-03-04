class Users::SessionsController < Devise::SessionsController
  
  # Disable CSRF protection
  skip_before_action :verify_authenticity_token
  #prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  after_filter :set_csrf_header, only: [:new, :create]

  # Be sure to enable JSON.
  respond_to :html, :json
  
  def create
    content_type = request.headers["Content-Type"] 
    puts "***** CREATE ***** " + content_type
    if content_type.include? "application/json"
      self.resource = warden.authenticate!(auth_options)
      #sign_in(resource_name, resource)
      render json: { :success => true , status: 200}
    else
      self.resource = warden.authenticate!(auth_options)
      if self.resource.two_factor_enabled
        respond_to do |format|
         format.html { redirect_to "/phone_numbers/new" }
        end
      end
    end
  end

  def failure
     content_type = request.headers["Content-Type"] 
     puts "***** FAIL ***** " + content_type
     if content_type.include? "application/json"
       render :json => {:success => false, status: 401}
     else
       respond_to do |format|
         format.html { redirect_to request.referer, error: 'Login Failed' }
         format.json { head :no_content }
       end
     end
  end
  
  # DELETE /resource/sign_out
  def destroy
    puts "DELETE /resource/sign_out"
    return render :json => {:success => true}, status: 200
  end

  #def failure
  #  return render :json => {:success => false, :errors => ["Login failed."], status: 401}
  #end
   def createNEWKO
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

     if content_type.include? "application/json"
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      render json: { :success => true }, status: 200
    else
      super
    end
  end
 
 # POST /resource/sign_in
 #  def createNEWKO
 #    self.resource = warden.authenticate!(auth_options), if: :json_request?
 #    set_flash_message(:notice, :signed_in) if is_flashing_format?
 #    sign_in(resource_name, resource)
 #    yield resource if block_given?
 
 #    respond_with resource, location: after_sign_in_path_for(resource) do |format|
 #      format.json { render json: {user_email: resource.email, access_token: resource.access_token} }
 #    end
 #  end
  

 # def failure   
 #   warden.custom_failure!
 #   render json: { success: false, errors: ["Login Credentials Failed"] }, status: 401
 # end

  protected
  def auth_options
    {:scope => resource_name, :recall => "#{controller_path}#failure"}
    #{:scope => resource_name}
  end
  
  def json_request?
    request.format.json?
  end
  
  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end


end