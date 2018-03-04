class StatusesController < ApplicationController

  before_action :set_status, only: [:show, :edit, :update, :destroy]
  layout 'messages'
  respond_to :html

  def index
    @statuses = Status.all
    respond_with(@statuses)
  end

  def show
    respond_with(@status)
  end

  def new
    @status = Status.new
    respond_with(@status)
  end

  def edit
    
  end

  def create
    @status = Status.new(status_params)
    @status.user_id=current_user.id
    @status.current = true
    @status.set_at = DateTime.now
    @status.save
    #respond_with(@status)
    redirect_to(request.referer, :notice => 'New status has been set')
  end
  
  def usestatus
    @status = Status.find(params[:status_id])
    @status.user_id=current_user.id
    @status.current = true
    @status.set_at = DateTime.now
    @status.update(status_params)
    respond_to do |format|
      format.html { redirect_to request.referer,:notice => t('Status reused') }
      format.json { head :no_content }
    end
  end

  def update
    @status = Status.find(params[:status_id])
    @status.user_id=current_user.id
    @status.current = true
    @status.set_at = DateTime.now
    @status.update(status_params)
     respond_to do |format|
       format.html { redirect_to request.referer,:notice => t('Status updated') }
       format.json { head :no_content }
    end    
  end

  def destroy
    @status.destroy
    respond_to do |format|
       format.html { redirect_to request.referer,:notice => t('Status deleted') }
       format.json { head :no_content }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def status_params
      params[:status]
    end
end
