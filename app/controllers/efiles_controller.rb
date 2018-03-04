class EfilesController < ApplicationController
  
  #before_filter :authenticate_user!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @efiles = Efile.all
    respond_to do |format|
      format.html 
      format.json { render json: @efiles }
    end
  end

  def show
    @efile = Efile.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @efile }
    end
  end

  def new
    @efile = Efile.new
    respond_to do |format|
      format.html
      format.json { render json: @efile }
    end
  end

  def edit
    @efile = Efile.find(params[:id])
  end

  def create
    @efile = Efile.new(params[:efile])
  #  @efile.user_id = current_user.id
    respond_to do |format|
      if @efile.save
        format.html { redirect_to efiles_url, notice: t('Efile successfully created') }
        format.json { render json: @efile, status: :created, location: @efile }
      else
        format.html { render action: "new" }
        format.json { render json: @efile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @efile = Efile.find(params[:id])
    respond_to do |format|
      if @efile.update_attributes(params[:efile])
        format.html { redirect_to efiles_url, notice: t('EFile updated successfully') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @efile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @efile = Efile.find(params[:id])
    @efile.destroy
    respond_to do |format|
      format.html { redirect_to efiles_url }
      format.json { head :no_content }
    end
  end
  
end
