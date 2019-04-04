class Api::V1::SearchController < ApplicationController

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_search, :except => [:index, :create]
  before_action :doorkeeper_authorize! # Require access token for all actions
  
  def fetch_search
    @search = Question.find_by_id(params[:id])
  end

  def index
    @searchs = Question.all
    respond_to do |format|
      format.json { render json: @searchs }
      format.xml { render xml: @searchs }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @search }
      format.xml { render xml: @search }
    end
  end

  def create
    @search = Question.new(params[:search])
  
    respond_to do |format|
      if @search.save
        format.json { render json: @search, status: :created }
        format.xml { render xml: @search, status: :created }
      else
        format.json { render json: @search.errors, status: :unprocessable_entity }
        format.xml { render xml: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @search.errors, status: :unprocessable_entity }
        format.xml { render xml: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def rebuild_pg_search_documents
    if current_user.role? :admin
      Product.find_each{ |record| record.update_pg_search_document }
      Paper.find_each{ |record| record.update_pg_search_document }
      Download.find_each{ |record| record.update_pg_search_document }
      Post.find_each{ |record| record.update_pg_search_document }
      Link.find_each{ |record| record.update_pg_search_document }
      Group.find_each{ |record| record.update_pg_search_document }
      User.find_each{ |record| record.update_pg_search_document }
      respond_to do |format|
        format.json { head :no_content, status: 200 }
        format.xml { head :no_content, status: 200 }
      end
    else
      respond_to do |format|
        format.json { head :no_content, status: 403 }
        format.xml { head :no_content, status: 403 }
      end
    end
  end

end