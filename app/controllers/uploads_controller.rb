class UploadsController < ApplicationController

  load_and_authorize_resource
  # before_action :set_bigisp, only: [:show, :edit, :update, :destroy]

  def index
    @uploads = Upload.where(:user_id=>current_user.id)
  end
 
  def new
    @upload = Upload.new
  end
  
  def show
    @upload = Upload.find(params[:id])
  end
 
  def create
    @upload = Upload.create(upload_params)
    @upload.user_id = current_user.id
    if @upload.save
      # send success header
      render json: { message: "success", fileID: @upload.id }, :status => 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 400
    end     
  end
 
  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy    
      render json: { message: "File deleted" }
    else
      render json: { message: @upload.errors.full_messages.join(',') }
    end
  end
 
  private
  def upload_params
    params.require(:upload).permit(:image)
  end
end
