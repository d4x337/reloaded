class IndexController < ApplicationController
 
  #layout :custom_layout
  layout 'indexnew'
 
  def about
    
  end
   
  def landing
    
  end
  
  def index
  
  end

  def indexnew

  end
 
  def feedback
     @feedback = Feedback.new    
  end 
  
  def configuration

  end 
 
  def advertising
    
  end
 
  def privacy
    
  end
 
   
  def help
    
  end
  
  def terms
    
  end
  
  
  def social
    
  end

  def setcoupon
    if params[:couponCode].blank?
      render :json => [false]
      return
    else
      coupon = params[:couponCode]
    end
    @coupon = Coupon.find_by_code(coupon)
    if @coupon.blank?
      render :json => [false]
    else

      @amount = Option.find_by_name('CONTRIBUTION').value.to_i
      @discount_amount = (@amount/100) * (@coupon.discount_percent)
      @final_amount = @amount - @discount_amount.to_i

      respond_to do |format|
        format.json { render json: @amount }
        format.json { render json: @discount_amount }
        format.json { render json: @coupon }
        format.json { render json: @final_amount }
        format.html  { redirect_to('/activation', :notice => 'Coupon added successfully.') }
      end

    end
  end

  def addcoupon
    if params[:couponCode].blank?
      render :json => [false]
      return
    else
      coupon = params[:couponCode]
    end
    @coupon = Coupon.find_by_code(coupon)
    if @coupon.blank?
      render :json => [false]
    else

      @amount = Option.find_by_name('CONTRIBUTION').value.to_i
      @discount_amount = (@amount/100) * (@coupon.discount_percent)
      @final_amount = @amount - @discount_amount.to_i
      render :json => @final_amount
    end
  end

  def checknick
    if params[:nickname].blank?
      render :json => [false]
      return
    else
      nickname = params[:nickname]
    end
    @user = User.find_by_nickname(nickname.downcase)
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
    @user = User.find_by_email(email.downcase)
    
    if @user.blank?
       render :json => [true]
    else
      render :json => [false]
    end
  end

  private
  def custom_layout
    case action_name
      when "about","terms"
        "devise"
      when "indexnew"
        "indexnew"
      when "superlogin"
        "test"
     end    
   end
 
end
