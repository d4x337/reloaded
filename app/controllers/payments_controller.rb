class PaymentsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "dashboard"

  def create
    payment = Payment.create(payments_params.merge(
        :price_in_cents => 1000,                  # €10.00 in cents
        :return_url => payment_url(payment),      # This is where the customer will be returned to
        :description => 'A Dutch windmill'        # This will end up on the customer's bank statement (max 32 ASCII chars)
    ))

    response = ideal.setup_purchase(payment.price_in_cents, payment.ideal_attributes)
    if response.success?
      payment.transaction_id = response.transaction_id
      payment.status = 'pending'
      payment.save(false)
    else
      Rails.logger.info("Payment initialization failed: [#{response.error_message}] #{response.error_details}")
    end

    # Redirect the consumer to the issuer’s payment page.
    redirect_to response.service_url
  end

  def index
      if (current_user.role? :admin) or (current_user.role? :master)
        @payments = Income.where(:user_id=>0).order(:created_at).reverse_order
      elsif (current_user.role? :cpr) or (current_user.role? :pr) or (current_user.role? :prj)
        @payments = Income.where(:user_id=>current_user.id).order(:created_at).reverse_order
      end
      respond_to do |format|
       format.html # index.html.erb
       format.json  { render :json => @payments }
     end
  end


  def payments_params
    params.fetch(:payment,{}).permit(:utf8,
                                                :user_id,
                                                :income_id,
                                                :order_id,
                                                :status,
                                                :una_tantum,
                                                :income,
                                                :income_type,
                                                :expiration,
                                                :auto_renew,
                                                :deleted)
  end

  def show
    @payment = Payment.find(params[:id])
    status = ideal.capture(@payment.transaction_id)
    if status.success?
      @payment.update_attributes!(:status => 'paid')
      flash[:notice] = "Congratulations, you are now the proud owner of a Dutch windmill!"
    end
  end

end



