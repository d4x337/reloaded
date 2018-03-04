class ContactsController < ApplicationController
  
  load_and_authorize_resource
  before_action :set_contact, only: [:show, :edit, :update, :destroy,:crop]
  layout 'search'


  def index
    @contacts = current_user.contacts

    respond_to do |format|
      format.html
      format.json  { render :json => @contacts }
    end
  end

  def indexOLD
    @message = Message.new
    @sent = Message.where(:sender_id=>current_user.id).order(:created_at).reverse_order
    @received = Message.where(:target_id=>current_user.id).order(:created_at).reverse_order
    respond_to do |format|
      format.html 
      format.json  { render :json => @sent }
      format.json  { render :json => @received }
      format.json  { render :json => @message }
    end
  end


 def gallery
    @contacts = current_user.contacts.paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html
  
      format.json  { render :json => @contacts }
    end
  end
  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end


  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      if params[:contact][:picture].blank?
        redirect_to root_url  #where you want to redirect.
      else
        render :action => 'crop'
      end
    else
      render :action => 'new'
    end
  end

 
  def update
   if @contact.update_attributes(contact_params)
      if params[:contact][:picture].blank?
        redirect_to root_url
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  def crop
    @contact = Contact.find(params[:id])
    @contact.update_attributes(crop_params)
    @contact.picture.reprocess!  #crop the image and then save it.
    redirect_to contact_path(@contact.id)
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params[:contact]
    end
    
    def crop_params
      params.require(:contact).permit(:crop_x, :crop_y, :crop_w, :crop_h)
    end
  
end
