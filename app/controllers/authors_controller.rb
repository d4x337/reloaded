class AuthorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'dashboard'

  def index
     #@things = current_user.things
    @authors = Author.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @authors }
    end
  end
  
  def admin
     #@things = current_user.things
    @authors = Author.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @authors }
    end
  end


  def show
    @author = Author.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @authors }
    end
  end

  def new
    @author = Author.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @author }
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(params[:author])
    respond_to do |format|
      if @author.save
        if params[:author][:photo].blank?
          flash[:notice] = "Successfully created new Author."
          format.html  { redirect_to(authors_url, :notice => 'author was successfully created.') }
          format.json  { head :no_content }
        else
          render :action => "crop"
        end
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @author.errors,:status => :unprocessable_entity }
      end
    end
  end

  def update
    @author = Author.find(params[:id])
    respond_to do |format|
      if @author.update_attributes(params[:author])
          render :action => "crop"
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @author.errors,:status => :unprocessable_entity }
      end
    end

  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
       format.html { redirect_to authors_url }
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
