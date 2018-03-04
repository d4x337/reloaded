class OrdersController < ApplicationController
  
  #include ActiveMerchant::Billing
  before_filter :authenticate_user!,:except =>[:new,:create,:show,:index,:express,:success,:failure]
  load_and_authorize_resource
  layout "dashboard"

  def checkout
     setup_response = ::GATEWAY.setup_purchase(2000,
      :ip => request.remote_ip,
      :return_url => url_for('confirm'),
      :cancel_return_url => url_for(root_path),
     )
    redirect_to ::GATEWAY.redirect_url_for(setup_response.token)
  end

  def index
     if params[:st]
      if params[:st] == "Completed"
           transaction_id = params[:tx]
           status         = params[:st]
           amount         = params[:amt]
           currency       = params[:cc]
           @ipn = PaymentNotification.where("params LIKE ?", "%#{transaction_id}%").first
           @order = Order.where(:cart_id=>@ipn.cart_id).first
           @order.transaction_id = transaction_id
           @order.status = status
           @order.amount = amount
           @order.currency = currency
           @order.save!
           render :action => "success"
      else
        render :action => "failure"
      end
    else
        redirect_to index_url
    end
 end
 
  def show
    @order  = Order.find(params[:id])
    @cart = Cart.find(@order.cart_id)
    session[:order_id] = @order.id
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @order }
      format.json  { render :json => @cart }
    end
  end
  
  def success
    @order = Order.find(session[:order_id])
  end

  def notification
    if params[:st]
      if params[:st] == "Completed"
           transaction_id = params[:tx]
           status         = params[:st]
           amount         = params[:amt]
           currency       = params[:cc]
           # select cart_id from payment_notifications where params like '%73B69983WG009831D%';
           @ipn = PaymentNotication.where("params like '%?%'", transaction_id).first
           @order = Order.where(:cart_id=>@ipn.cart_id)
           @order.update_attributes(:transaction_id=>transaction_id,:status=>status,:amount=>amount,:currency=>currency) 
           render :action => "success"
      else
        render :action => "failure"
      end
    else
        render :action => "failure"
    end
  end
 
  def express
    @order   = Order.new(params[:order])
    @cart    = Cart.find(params[:cart_id])
    @product = Product.find(params[:prod_id])
    @dd00r = false
  
    @order.ip_address = request.remote_ip
    @order.cart_id = @cart.id
    @order.domain = params[:domain]
    
    @order.email = @order.nick+"@"+@order.domain
    @order.user_id = 0
    @order.prod_id = @cart.prod_id
    @order.quantity = @cart.items
    @order.package = @product.name
    @order.total = @product.final_price+@order.quantity
    @order.starts_on = DateTime.now
    @order.expires_on = DateTime.now+(@order.quantity).year
   
    @expiration = params[:month]+"/"+params[:year]+"/"+params[:month]+"/01"
    @order.card_expires_on = @expiration
   
    @order.invoice_id = 0

    if @order.save
        session[:order_id] = @order.id
        response = EXPRESS_GATEWAY.setup_purchase(@order.total*100,
          :ip                => request.remote_ip,
          :return_url        => "success",
          :cancel_return_url => @cart
        )
        redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
        render :action => "success"
    else
      respond_to do |format|
       format.json  { render :json => @order.errors, :status => :unprocessable_entity }
       format.html  { redirect_to(request.referer, :alert => t('error while processing order')) }
      end
    end
  end
  
  
  
  def new
   
    if session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
    elsif not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
    end

    @order = Order.new#(:express_token => 1234)
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @cart }
      format.json  { render :json => @order }
    end
  end

  def edit
    @order  = Order.find(params[:id])
  end

  def update
    @order  = Order.find(params[:id])
    respond_to do |format|
    if @order.update_attributes(params[:order])
      format.html  { redirect_to(@order, :notice => 'Order was successfully updated.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @order.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
    @order  = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
       format.html { redirect_to orders_url }
       format.json { head :no_content }
    end
  end

 
  def create
 
    @order   = Order.new(params[:order])
    
    if session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      elsif not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
      elsif current_user
        @cart = Cart.where(:user_id=>current_user.id).first
      else
        @cart  = Cart.new(params[:cart])
        session[:cart_id] = @cart.id
    end

   
    only_beta_test = false
    @cart.cart_products.each do |item|
      @product = Product.find(item.product_id)
      if @product.summary == "FREE"
        if @cart.cart_products.count == 1
           only_beta_test = true
        end
      end
   end
   
     
    count_free_boxes = 0
    pass = Option.find_by_name('MASTER_DD00R').value
    
    dd = false
    @order.save!
    
    @cart.cart_products.each do |item|
      if is_service(item.product_id)
        if item.nickname.end_with?(pass)
          count_free_boxes += 1
        end
        if @cart.cart_products.count == count_free_boxes
          dd = true
          item.nickname.gsub!(pass,"")
          item.save!
          @order.internal_notes = "FREEBOX DD"
          @order.save!
          @order.rows.create(:order_id=>@order.id,:product_id=>item.product_id,:single=>item.single_price,:quantity=>item.quantity,:total=>item.total_price,:nickname=>item.nickname,:domain=>item.domain)      
        else
          dd = false
           @order.rows.create(:order_id=>@order.id,:product_id=>item.product_id,:single=>item.single_price,:quantity=>item.quantity,:total=>item.total_price,:nickname=>item.nickname,:domain=>item.domain)      
        end
      else
        @order.rows.create(:order_id=>@order.id,:product_id=>item.product_id,:single=>item.single_price,:quantity=>item.quantity,:total=>item.total_price)      
      end
    end
    
    @cart.order_id = @order.id
    @cart.save!
  
    @order.ip_address = request.remote_ip
    @order.cart_id = @cart.id
  
    @order.user_id = 0
    @order.quantity = @cart.cart_products.count
    @order.total = @cart.total_price
    @order.starts_on = DateTime.now
    @order.expires_on = DateTime.now+(@order.quantity).year
   
   # @expiration = params[:month]+"/"+params[:year]+"/"+params[:month]+"/01"
   # @order.card_expires_on = @expiration
    @order.invoice_id = 0
 
    if @order.save
        if dd
             render :action => "success"
        elsif only_beta_test == true
             render :action => "success"
        else
            session[:order_id] = @order.id
            respond_to do |format|
              format.html  { redirect_to(@order, :notice => 'Order confirmed, proceed with payment.') }
             format.json  { render :json => @cart }
            end
        end
    else
      respond_to do |format|
       format.json  { render :json => @order.errors, :status => :unprocessable_entity }
#       format.html  { redirect_to(request.referer, :alert => t('error while processing order')) }
      end
    end
  end

  private

  def is_service(prod_id)
    @product = Product.find(prod_id)
    if @product.category == "service"
      return true
    else 
      return false
    end
  end
   
  def order_parameters
    params.permit(:id,:last_name, :first_name,
      :cart_id,
      :prod_id,
      :quantity,
      :subscription,
      :annual,
      :starts_on,
      :expires_on,
      :nick,
      :email,
      :domain,
      :package,
      :invoice_id,
      :ip_address,
      :first_name,
      :last_name,
      :card_type,
      :card_expires_on,
      :total)
  end
  
  def resolve_layout
    case action_name 
    when "index" 
      "social"
    when "new" 
      "social"
    when "show" 
      "social"
    when "edit" 
      "social"
     else
      "application"
    end       
  end
 
  
end



