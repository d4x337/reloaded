class Api::V1::CountriesController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_action :doorkeeper_authorize! # Require access token for all actions
 # before_filter :fetch_country, :except => [:index, :create]
  
  before_action -> { doorkeeper_authorize! :public }, only: :index
  
  before_action only: [:create, :update, :destroy] do
    doorkeeper_authorize! :admin
    doorkeeper_authorize! :write
  end
  
  def fetch_country
    @country = Country.find_by_id(params[:id])
  end

  def index
    @countries = Country.all
    respond_to do |format|
      format.json { render json: @countries }
      format.xml { render xml: @countries }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @country }
      format.xml { render xml: @country }
    end
  end

  def create
    @country = Country.new(params[:country])
  
    respond_to do |format|
      if @country.save
        format.json { render json: @country, status: :created }
        format.xml { render xml: @country, status: :created }
      else
        format.json { render json: @country.errors, status: :unprocessable_entity }
        format.xml { render xml: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @country.errors, status: :unprocessable_entity }
        format.xml { render xml: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @country.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @country.errors, status: :unprocessable_entity }
        format.xml { render xml: @country.errors, status: :unprocessable_entity }
      end
    end
  end
end