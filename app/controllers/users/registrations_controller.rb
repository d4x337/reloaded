class Users::RegistrationsController < Devise::RegistrationsController
   
  before_filter :configure_permitted_parameters
 
  def create
    registrations_status = Option.where(:name=>'REGISTRATIONS_STATUS').first
    if registrations_status.value  == "INVITED_ONLY"
      if params[:invitation_token].present?
        super
      else
        respond_to do |format|
          format.html  { redirect_to(request.referer, :alert =>' Sorry '+params[:user][:email]+', You are not on our invitations list') }
        end
      end
    else
      super
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:firstname, :mobile, :nickname, :email, :locale, :secret_answer)
  end
 
end
