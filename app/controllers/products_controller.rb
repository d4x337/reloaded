class ProductsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'dashboard'

  def index
     @products  = Product.all
      respond_to do |format|
      format.html
      format.json  { render :json => @products }
     end
  end

  def store
    if session[:cart_id].present?
      begin
        @cart = Cart.find(session[:cart_id])
      rescue
        @cart = Cart.new
      end
    elsif not params[:cart_id].blank?
      @cart  = Cart.find(params[:cart_id])
    else
      @cart  = Cart.new(params[:cart])
      session[:cart_id] = @cart.id
    end
    @cart_product = @cart.cart_products.new
    @products  = Product.where(:in_stock=>true)
    respond_to do |format|
      format.html
      format.json  { render :json => @cart_product }
      format.json  { render :json => @products }
      format.json  { render :json => @cart }
    end
  end

  def show
   if session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      elsif not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
      else
        @cart  = Cart.new(params[:cart])
        session[:cart_id] = @cart.id
      end
      
    @active_services = Product.where(:category=>'service')
    @domains = Domain.where(:active=>1)
   
    @cart_product = @cart.cart_products.new
    @product  = Product.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
       format.json  { render :json => @cart }
       format.json  { render :json => @active_services }
       format.json  { render :json => @domains }
           format.json  { render :json => @product }
      format.json  { render :json => @cart_product }
    end
  end

  def new
    @product  = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @products }
    end
  end

  def edit
    @product  = Product.find(params[:id])
  end

  def create
    @product  = Product.new(params[:product])
      respond_to do |format|
      if @product.save
        format.html  { redirect_to(products_url,
                  :notice => 'Product successfully created.') }
        format.json  { render :json => @product, :status => :created, :location => @product }
 
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @product  = Product.find(params[:id])
    respond_to do |format|
    if @product.update_attributes(product_params)
      format.html  { redirect_to(products_url, :notice => 'Product successfully updated.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @product.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
  @product  = Product.find(params[:id])
  @product.destroy
    respond_to do |format|
       format.html { redirect_to products_url }
       format.json { head :no_content }
    end
  end

  def product_params
    params.fetch(:product,{}).permit(
                                  :utf8,
                                  :name,
                                  :description,
                                  :summary,
                                  :final_price,
                                  :costs,
                                  :category,
                                  :currency,
                                  :quota,
                                  :subscription,
                                  :pay_once,
                                  :in_stock,
                                  :promo,
                                  :active,
                                  :photo_file_name,
                                  :photo_content_type,
                                  :photo_file_size,
                                  :photo_updated_at)
  end

   private
   def resolve_layout
    case action_name 
    when "show" 
      "shopping"
    else
      "social"
    end       
   end
 
end



