class InvoicesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:top]
  load_and_authorize_resource
  layout "dashboard"

  def index
    if current_user.role? :author
      @invoices = Invoice.all
    else
      @invoices = Invoice.where(:visible => true)
    end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @invoices }
    end
  end
  
  def past
    if current_user.role? :author
     @invoices = Invoice.where('starting_date <= (?)',DateTime.now).order(:starting_date)
    else
     @invoices = Invoice.where('starting_date <= (?) and visible = ?',DateTime.now,true).order(:starting_date)
    end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @invoices }
    end
  end


  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @invoice }
    end
  end

  def new
    @invoice = Invoice.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @invoices }
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def create
    @invoice = Invoice.new(params[:invoice])
      respond_to do |format|
      if @invoice.save
        format.html  { redirect_to(invoices_url,:notice => t('invoice was successfully created.')) }
        format.json  { render :json => @invoice, :status => :created, :location => @invoice }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
    if @invoice.update_attributes(params[:invoice])
      format.html  { redirect_to(invoices_url, :notice => t('invoice was successfully updated.') ) }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @invoice.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
  @invoice = Invoice.find(params[:id])
  @invoice.destroy
    respond_to do |format|
       format.html { redirect_to invoices_url }
       format.json { head :no_content }
    end
  end
  
  private
  def custom_layout
       if current_user.role? :admin  
        "dashboard"    
       else current_user.role? :user
        "welcome"
       end 
   end
   
end


