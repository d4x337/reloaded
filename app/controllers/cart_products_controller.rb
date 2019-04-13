class CartProductsController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard'

  def create
    current_cart.cart_items.create!(params[:cart_item])
    flash[:notice] = "Product added to cart"
    session[:last_product_page] = request.env['HTTP_REFERER'] || products_url
    redirect_to current_cart_url
  end
  
  def index
    @cart_items = CartProduct.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def show
    @cart_items = CartProduct.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def new
    @cart_items = CartProduct.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def edit
    @cart_items = CartProduct.find(params[:id])
  end

  def create
      if not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
        session[:cart_id] = @cart.id
      elsif session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      else
         if current_user
          @cart = Cart.where(:user_id=>current_user.id).first
            if not @cart
              @cart  = Cart.new(cart_params)
              session[:cart_id] = @cart.id
              @cart.user_id = current_user.id
              @cart.currency = 'euro'
              @cart.items = 0
              @cart.status = "EMPTY CART"
              @cart.total_price = 0
              @cart.last_operation = DateTime.now
              @cart.ip = request.env["REMOTE_ADDR"]
              @cart.save!
            end
         else
            @cart  = Cart.new()
            session[:cart_id] = @cart.id
            @cart.currency = 'euro'
            @cart.items = 0
            @cart.status = "EMPTY CART"
            @cart.total_price = 0
            @cart.last_operation = DateTime.now
            @cart.ip = request.env["REMOTE_ADDR"]
            @cart.save!
         end
      end
      @prod  = Product.find(params[:prod_id])

      @items = params[:items].to_i
      if @items < 2 or @items.blank?
        @items = 1
      end    
    
      @domain = params[:domain]
      @nick = params[:nickname]
  
      
      @total_price = @prod.final_price.to_i*@items.to_i
   
      @cart.total_price += @total_price
      @cart.items += @total_price
      
       if @prod.subscription == "single"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*@items )
      elsif @prod.subscription == "unatantum"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "free"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>0 ,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      elsif @prod.subscription == "annual"
         @cart.cart_products.create(:cart_id=>@cart.id,:product_id=>params[:prod_id],:quantity=>@items,:single_price=>@prod.final_price,:total_price =>@prod.final_price*12,:domain=>@domain,:nickname=>@nick,:status=>@nick+"@"+@domain )
      end
  
     respond_to do |format|
      if @cart.save
        session[:cart_id] = @cart.id
        if request.referer
          if request.referer.end_with? 'email'
             format.html  { redirect_to(@cart,:notice => @prod.name+" added to cart") }
          else
             format.html  { redirect_to(request.referer,:notice => @prod.name+" added to cart") }
          end
       else
           format.html  { redirect_to(request.referer,:notice => @prod.name+" added to cart") }
        end
      
      else
        format.html  { render :action => "new" }
        format.html  { redirect_to(request.referer, :notice => "Failed to add "+@prod.name) }
      end
      end
  end
  
  def update
    @cart_items = CartProduct.find(params[:id])
    if  params[:cart_item][:quantity].to_i == 0
       @cart_items.destroy
       respond_to do |format|
          format.html  { redirect_to("/cart", :notice => 'Your Cart has been updated..') }
          format.json  { render :json => @cart_items,:status => :updated, :location => @cart_items }
      end
    else
        @cart_items.total_price = params[:cart_item][:quantity].to_i * @cart_items.single_price
        
        if @cart_items.update_attributes(params[:cart_item])
            @cart = Cart.find(@cart_items.cart_id)
            @tot_quantity = 0
            @tot_cart = 0
            @cart.cart_items.each do |xitem|
              @tot_quantity = @tot_quantity + xitem.quantity  
              @tot_cart = @tot_cart + xitem.total_price  
            end
            @cart.total_price = @tot_cart
            @cart.items = @tot_quantity
            @cart.save!
             respond_to do |format|
              format.html  { redirect_to("/cart", :notice => 'Your Cart has been updated.') }
              format.json  { render :json => @cart_items,:status => :updated, :location => @cart_items }
          end
        
        end    
     end
  end
 

 def destroy
    @item = CartProduct.find(params[:id])

    @quantity   = @item.quantity
    @unit_price = @item.single_price
    @total_price= @item.total_price
    @product    = Product.find(@item.product_id)
    @cart = Cart.find(@item.cart_id)
     
    @item.destroy

    @cart.total_price = 0
    @cart.cart_products.each do |item|
       @cart.total_price += item.total_price
    end
    @cart.save!
  
    respond_to do |format|
       format.html  { redirect_to(request.referer, :notice => 'Successfully removed '+@product.name) }
        format.json  { render :json => @cart,:status => :updated, :location => @cart }
     end
  end

  def delete
    @item = CartProduct.find(params[:id])

    @quantity   = @item.quantity
    @unit_price = @item.single_price
    @total_price= @item.total_price
    @product    = Product.find(@item.prod_id)
    @cart = Cart.find(@item.cart_id)
     
    @item.destroy

    @cart.total_price = @cart.total_price-@total_price
    @cart.items = @cart.items-@quantity
    @cart.save!
  
    respond_to do |format|
       format.html  { redirect_to("/cart", :notice => 'Successfully removed '+@product.name) }
        format.json  { render :json => @cart,:status => :updated, :location => @cart }
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

end