class ChargesController < ApplicationController

  layout "dashboard"

  def new
  end

  def create
    # Amount in cents
    @amount = Option.find_by_name('CONTRIBUTION').value
    @final_amount = @amount
    @code = params[:couponCode]

    if !@code.blank?
      @discount = get_discount(@code)

      if @discount.nil?
        flash[:error] = 'Coupon code is not valid or expired.'
        redirect_to root_path
        return
      else
        @discount_amount = @amount * @discount
        @final_amount = @amount.to_i - @discount_amount.to_i
      end

      charge_metadata = {
          :coupon_code => @code,
          :coupon_discount => (@discount * 100).to_s + "%"
      }
    end

    charge_metadata ||= {}

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    @user = User.find_by_email(params[:stripeEmail])
    if @user
      @user.approved = true
      @user.payed = true
      @user.subscription_start = DateTime.now
      @user.subscription_end = DateTime.now+1.year
      @user.save
    else
      # save payments with un registered email for future matching, avoiding incidents
    end

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Tortuga Subscription',
        :currency    => 'eur',
        :metadata    => charge_metadata
    )
    flash[:notice] =  'Thank you '+params[:stripeEmail]+'! We received your subscription payment <br>and your account is ready!'
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def get_discount(code)
    # Normalize user input
    code = code.gsub(/\s+/, '')
    code = code.upcase
    coupon = Coupon.find_by_code(code)
    if coupon
      code = coupon.discount_percent
    end

  end

end
