class AdsController < ApplicationController
  before_filter :authenticate_user!, :except => [:top]
  load_and_authorize_resource 
  layout 'dashboard'

  def index
      @ads = Ad.paginate(:page => params[:page])
      respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @ads }
    end
  end
  
  def sponsored
      @ads = Ad.where(:active => true)
      respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @ads }
    end
  end
  
  def top
     @ads = Ad.where(:active => true)
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @exploits }
    end
  end
   
  def show
    @ad = Ad.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @ad }
    end
  end

  def new
    @ad = Ad.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @ads }
    end
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(params[:ad])
      respond_to do |format|
      if @ad.save
        format.html  { redirect_to(ads_url,:notice => t('Advertising successfully created')) }
        format.json  { render :json => @ad, :status => :created, :location => @ad }
 
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ad = Ad.find(params[:id])
    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html  { redirect_to(ads_url, :notice =>  t('Advertising successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  @ad = Ad.find(params[:id])
  @ad.destroy
    respond_to do |format|
       format.html { redirect_to ads_url }
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


