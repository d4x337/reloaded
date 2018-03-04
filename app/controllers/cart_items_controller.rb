class CartItemsController < ApplicationController
  
  def create
    current_cart.cart_items.create!(params[:cart_item])
    flash[:notice] = "Product added to cart"
    session[:last_product_page] = request.env['HTTP_REFERER'] || products_url
    redirect_to current_cart_url
  end
  
  def index
    #@things = current_user.things
    @cart_items = CartItems.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def show
    @cart_items = CartItem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def new
    @cart_items = CartItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @cart_items }
    end
  end

  def edit
    @cart_items = CartItem.find(params[:id])
  end

  def create
    @cart_items = CartItem.new(params[:cart_item])
    respond_to do |format|
      if @cart_items.save
        format.html  { redirect_to(request.referer,:notice => 'Item was successfully created.') }
        format.json  { render :json => @cart_items,:status => :created, :location => @cart_items }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @cart_items.errors,:status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @cart_items = CartItem.find(params[:id])
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
    @cart_items = CartItem.find(params[:id])
    @cart_items.destroy

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
       format.html { redirect_to "/cart" }
       format.json { head :no_content }
    end
  end

end