class Api::V1::UploadsController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_upload, :except => [:index, :create]
  before_action :doorkeeper_authorize! # Require access token for all actions
  
  def fetch_upload
    @upload = Upload.find_by_id(params[:id])
  end

  def index
    @uploads = Upload.all
    respond_to do |format|
      format.json { render json: @uploads }
      format.xml { render xml: @uploads }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @upload }
      format.xml { render xml: @upload }
    end
  end

  def create
    @upload = Upload.new(params[:upload])
  
    respond_to do |format|
      if @upload.save
        format.json { render json: @upload, status: :created }
        format.xml { render xml: @upload, status: :created }
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.xml { render xml: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.xml { render xml: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @upload.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.xml { render xml: @upload.errors, status: :unprocessable_entity }
      end
    end
  end
end