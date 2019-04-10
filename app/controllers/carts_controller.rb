class CartsController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard'
 
 def index
     #@things = current_user.things
    @carts = Cart.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @carts }
    end
  end
  
  def add_to_cart
      if not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
        session[:cart_id] = @cart.id
      elsif session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      end
      
      @items = params[:items]
      if not @items
        @items = 1
      end    
    
      @domain = params[:domain]
      @nick = params[:nickname]
    
      @prod = Product.find(params[:prod_id])
      @cart.save!
   
      if @prod.subscription == "single"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*@items )
      elsif @prod.subscription == "unatantum"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "free"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>0,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain  )
      elsif @prod.subscription == "annual"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*12,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      end
   
      respond_to do |format|
      if @cart.save
        session[:cart_id] = @cart.id
         format.html  { redirect_to(@cart, :notice => "Item "+@prod.name+" added to your cart") }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @cart.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  def create
     
      @cart  = Cart.new(cart_params)
      session[:cart_id] = @cart.id
   
      @prod = Product.find(params[:prod_id])
     
      @cart.currency = 'EURO'
      @cart.ip = request.env["REMOTE_ADDR"]
      @cart.items = 1
      @cart.last_operation = DateTime.now
   
      if not params[:invitation_token].blank?
        @cart.invitation_token = params[:invitation_token]
        session[:invitation_token] = params[:invitation_token]
      end
  
      if not params[:request_token].blank?
        if request_is_valid(params[:request_token])
          @cart.request_token = params[:request_token]
          session[:request_token] = params[:request_token]
        end
      end
    
      @items = params[:items].to_i
      if @items < 2 or @items.blank?
        @items = 1
      end    
      
      @domain = params[:domain]
      @nick = params[:nickname]
      @prod = Product.find(params[:prod_id])
      @cart.save!
   
      if @prod.subscription == "single"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*@items )
      elsif @prod.subscription == "unatantum"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "free"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>0,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain  )
      elsif @prod.subscription == "annual"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*12,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      end
   
      @cart.total_price = 0
      @cart.cart_products.each do |item|
       @xitem = Product.find(item.product_id)
        if @xitem.subscription == "single"
         @cart.total_price += @xitem.final_price
        elsif @xitem.subscription == "unatantum"
         @cart.total_price += @xitem.final_price
        elsif @xitem.subscription == "free"
         @cart.total_price += @xitem.final_price
        elsif @xitem.subscription == "annual"
         @cart.total_price += @xitem.final_price*12
        end
      end
      @cart.save!
   
      respond_to do |format|
        if @cart.save
            if request.referer.end_with?('email')
               format.html  { redirect_to(@cart,:notice => @prod.name+" added to cart") }
            else
               format.html  { redirect_to(request.referer,:notice => @prod.name+" added to cart") }
            end
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @cart.errors, :status => :unprocessable_entity }
        end
      end
  end
 
  def update
      if not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
        session[:cart_id] = @cart.id
      elsif session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      end
         
      @cart.currency = 'EURO'
      @cart.ip = request.env["REMOTE_ADDR"]
      @cart.last_operation = DateTime.now
 
      @items = params[:items]
      if not @items
        @items = 1
      end    
      
      @prod = Product.find(params[:prod_id])
      @domain = params[:domain]
      @nick = params[:nickname]
      @cart.save!
    
      if @prod.subscription == "single"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*@items )
      elsif @prod.subscription == "unatantum"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "free"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>0,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "annual"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*12,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      end
   
      @cart.save!
   
      @cart.total_price = 0
      @cart.cart_products.each do |item|
         @xitem = Product.find(item.product_id)
      
         if @xitem.subscription == "single"
           @cart.total_price += @xitem.final_price
          elsif @xitem.subscription == "unatantum"
           @cart.total_price += @xitem.final_price
          elsif @xitem.subscription == "free"
           @cart.total_price += @xitem.final_price
          elsif @xitem.subscription == "annual"
           @cart.total_price += @xitem.final_price*12
          end
       
      end
      @cart.save!
   
      respond_to do |format|
        if @cart.save
           session[:cart_id] = @cart.id
           if request.referer.end_with?('email')
              format.html  { redirect_to(@cart,:notice => @prod.name+" added to cart") }
           else
              format.html  { redirect_to(request.referer,:notice => @prod.name+" added to cart") }
           end
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @cart.errors, :status => :unprocessable_entity }
        end
      end
   end

  
  def update_cart
    if not params[:cart_id].blank? and not params[:prod_id].blank? and not params[:items].blank?
      @cart  = Cart.find(params[:cart_id])
      @prod  = Product.find(params[:prod_id])
      @items = params[:items]
      @cart.prod_id = params[:prod_id]
      @cart.total_price = @prod.final_price * 12
      @cart.last_operation = DateTime.now
      @cart.ip = request.env["REMOTE_ADDR"]
      @cart.items = @items
      @cart.status = @prod.name+" "+@cart.nick+"@"+@cart.domain+ " ("+@cart.items.to_s+" year subscription)"
      @cart.save
      
      render :json => [true]
   else
      render :json => [false]
      return
    end
  end


  def express_checkout
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

  def confirm
    @order   = Order.new(params[:order])
    @dd00r = false
    @order.ip_address = request.remote_ip
   
    @cart = Cart.find(params[:cart_id])
    @order.cart_id = cart_id
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

  def show
    
    @cart  = Cart.find(params[:id])
       
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @cart }
    end
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @cart }
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def createOLD
      @nick = params[:choosen_nick]
      @domain = params[:choosen_domain]
      @prod = Product.find(params[:prod_id])
      
      @cart = Cart.new
      @cart.currency = 'EURO'
      @cart.ip = request.env["REMOTE_ADDR"]
      @cart.items = 1
      @cart.total_price = @prod.final_price;
      @cart.status = "SHOPPING"
      @cart.domain = @domain
      @cart.nick = @nick
      @cart.prod_id = @prod
      @cart.last_operation = DateTime.now
 
    respond_to do |format|
      if @cart.save
          flash[:notice] = "Successfully added to Cart."
          format.html  { redirect_to(new_order_path, :notice => 'cart was successfully created.') }
          format.json  { head :no_content }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @cart.errors,:status => :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end

  def createOLD
      @cart  = Cart.find(params[:cart_id])
      @product  = Product.find(params[:prod_id])
      @items = params[:items]
     
      if not @items
        @items = 1
      end    
      
      @prod = Product.find(params[:prod_id])
      @cart.save!
      @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*@items )
   
      respond_to do |format|
        if @cart.save
          session[:cart_id] = @cart.id
            format.html  { redirect_to(request.referer, :notice => "Item "+@prod.name+" added to your cart") }
        else
            format.html  { redirect_to(request.referer, :notice => "Failed to add "+@prod.name+" to cart") }
        end
      end

  end

  protected


  def cart_params
    params.fetch(:cart,{}).permit(
    :order_id,
    :domain,
    :nick,
    :prod_id,
    :items,
    :currency,
    :status,
    :promo,
    :total_price,
    :ip,
    :purchased_at,
    :last_operation,
    :deleted)

  end


  private
  def resolve_layout
    case action_name 
    
    when "index" 
      "shopping"
    when "show" 
      "shopping"
    else
      "application"
    end       
 end


end
