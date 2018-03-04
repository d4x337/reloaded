class PicturesController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource
  layout "search"

  def new
    @upload = Upload.new
  end

  def create
    @picture = Picture.new
    @picture.pic = params[:file]
    @picture.user_id = current_user.id
    if @picture.save
      render json: { message: "success" }, :status => 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @picture.errors.full_messages.join(',')}, :status => 400
    end
  end

  def destroyOLD
    @picture = Upload.find(params[:id])
    if @picture.destroy
      render json: { message: "Picture deleted from server" }
    else
      respond_to do |format|
        format.html { redirect_to picture_url, :notice => 'Picture deleted successfully.' }
        format.json { head :no_content }
      end
    end
  end

  def index
    @pictures = Picture.all
    respond_to do |format|
      format.html
      format.json  { render :json => @pictures }
    end
  end

  def show
    @pictures  = Picture.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @pictures }
    end
  end

  def new
    @picture  = Picture.new
    respond_to do |format|
      format.html
      format.json  { render :json => @picture }
    end
  end

  def edit
    @picture  = Picture.find(params[:id])
  end

  def createOLD
    @picture  = Picture.new(params[:picture])
    respond_to do |format|
      if @picture.save
        format.html  { redirect_to(picture_url, :notice => 'Picture created successfully.') }
        format.json  { render :json => @picture, :status => :created, :location => @picture }

      else
        format.html  { render :action => "new" }
        format.json  { render :json => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @picture  = Picture.find(params[:id])
    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html  { redirect_to(picture_url, :notice => 'Picture updated successfully.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture  = Picture.find(params[:id])
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to picture_url, :notice => 'Picture deleted successfully.' }
      format.json { head :no_content }
    end
  end

end
