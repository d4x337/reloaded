class QuotesController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard'

  def index
      if current_user.role? :admin
          @quotes = Quote.order(:approved).reverse_order
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes }
    end
  end
  
  def popular
     @quotes = Quote.where(:visible => true).order(:clicks).reverse_order.paginate(:page => params[:page])
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes }
    end
  end
  
  def toprated
     @quotes = Quote.where(:visible => true).order(:rating).reverse_order.paginate(:page => params[:page])
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes }
    end
  end
  
  def last
     @quotes = Quote.where(:visible => true).order(:published).reverse_order.paginate(:page => params[:page])
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes }
    end
  end
 
  
  def famous
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
  
  def ispirational
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
  
  def proverbs
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
  
  def movie
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
  
  def author
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
 
 def language
      if current_user.role? :author
          @quotes = Quote.order(:approved).reverse_order.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).order(:approved).reverse_order.paginate(:page => params[:page])
      end
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end
  
 def rate
    @quote = Quote.find(params[:id])
    @quote.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @quote.wrapper_dom_id(params), ratings_for(@quote, params.merge(:wrap => false))
      page.visual_effect :highlight, @quote.wrapper_dom_id(params)
    end
  end
  
  def admin
      if current_user.role? :author
          @quotes = Quote.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).paginate(:page => params[:page])
      end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes_grid }
    end
  end

  def list
     if current_user.role? :author
          @quotes = Quote.paginate(:page => params[:page])
      else
          @quotes = Quote.where(:approved=>true).paginate(:page => params[:page])
      end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @quotes }
    end
  end

  def show
    @quote = Quote.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @quote }
    end
  end

  def new
    @quote = Quote.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @quote }
    end
  end

  def edit
    @quote = Quote.find(params[:id])
    
  end

def create
  @quote = Quote.new(params[:quote])
  @quote.user_id = current_user.id
      respond_to do |format|
        if @quote.save
          format.html  { redirect_to(quotes_url,
                        :notice => 'Quote was successfully created.') }
          format.json  { render :json => @quote,
                        :status => :created, :location => @quote }
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @quote.errors,
                        :status => :unprocessable_entity }
        end
      end
    
end

def update
  @quote = Quote.find(params[:id])
    respond_to do |format|
      if @quote.update_attributes(quote_params)
        format.html  { redirect_to(quotes_url, :notice => 'Quote was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @quote.errors,
                      :status => :unprocessable_entity }
      end
    end
end

  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_to do |format|
       format.html { redirect_to quotes_url }
       format.json { head :no_content }
    end
  end

  def quote_params
    params.fetch(:quote,{}).permit(
                                        :utf8,
                                        :qtext,
                                        :lang,
                                        :author_id,
                                        :user_id,
                                        :quote_type_id,
                                        :notes,
                                        :last_seen,
                                        :next_seen,
                                        :online_count,
                                        :visible,
                                        :approved,
                                        :today)
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
