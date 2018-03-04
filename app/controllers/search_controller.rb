class SearchController < ApplicationController

   #before_filter :authenticate_user!, :except => [:home]
   #load_and_authorize_resource
   include PgSearch
   layout 'search'
    
   def go_to_category
     
       @category = params[:category]
       @products = Product.where(:category=>@category,:active=>true)
       @active_services = Product.where(:category=>'service')
       @domains = Domain.where(:active=>1)
       @cart_product = CartProduct.new
    
       respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @cart_product }
        format.json  { render :json => @products }
        format.json  { render :json => @searched_item }
        format.json  { render :json => @results }
      end
   end
   
   def complete
     @output = []
     if params[:this].present?
     
       query = params[:this]
       query = query.downcase
       @result = User.partial_search(query)
       @result.each do |result|
         current_item = { :result => result.firstname}
         @output << current_item
        end
     end   
     logger.debug "Search Results => #{@output}"
     render json: @output
   end
  
   def completeOLD
     @output = []
     if params[:this].present?
       query = params[:this]
       query = query.upcase
       
       PgSearch.multisearch_options = { 
         :using => {
           :tsearch => {
             :dictionary => "english"
           },
           :trigram => {}
         },
         :ignoring => :accents
       }
       
       @result = PgSearch.multisearch(params[:this])
       @result.each do |result|
         current_item = { :result => result.content}
         @output << current_item
        end
     end   
     logger.debug "d4xSearch Results => #{@output}"
     render json: @output
   end
   
  def directory
    @users=User.all

  end
  
   def index
     @dircode = Option.where(:name=>'DIR_CODE').first
     if params[:findthis] == @dircode.value
       respond_to do |format|
        format.html  { redirect_to("/directory", :notice => 'Full Directory.') }
        format.json  { head :no_content }
       end
     else  
         PgSearch.multisearch_options = { :using => :tsearch }
         if (params[:findthis] != nil)
             @results = PgSearch.multisearch(params[:findthis]).paginate(:page => params[:page])
             @searched_item = params[:findthis].to_s
         end
        
          respond_to do |format|
            if (@results.present?)
        #     flash[:notice] = "Search Results for "+@searched_item
            else
         #    flash[:error] = "No Results Found with "+@searched_item
            end
            format.html # index.html.erb
            format.json  { render :json => @searched_item }
            format.json  { render :json => @results }
          end
     end   
  end
   
   def indexOLD
     PgSearch.multisearch_options = { :using => :tsearch }
     if (params[:findthis] != nil)
         @results = PgSearch.multisearch(params[:findthis]).paginate(:page => params[:page])
         @searched_item = params[:findthis].to_s
     end
      if session[:cart_id].present?
        @cart  = Cart.find(session[:cart_id])
      elsif not params[:cart_id].blank?
        @cart  = Cart.find(params[:cart_id])
      else
        @cart  = Cart.new(params[:cart])
        session[:cart_id] = @cart.id
      end
      
     @active_services = Product.where(:category=>'service')
     @domains = Domain.where(:active=>1)
     @cart_product = @cart.cart_products.new
    
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @searched_item }
      format.json  { render :json => @results }
    end
  end
  
  def rebuild_pg_search_documents
    Product.find_each{ |record| record.update_pg_search_document }
    Paper.find_each{ |record| record.update_pg_search_document }
    Download.find_each{ |record| record.update_pg_search_document }
    Post.find_each{ |record| record.update_pg_search_document }
    Link.find_each{ |record| record.update_pg_search_document }
    Group.find_each{ |record| record.update_pg_search_document }
    User.find_each{ |record| record.update_pg_search_document }
  end

   private
   def resolve_layout
     if (current_user != nil)
       "social"
     else
       "shopping"
     end 
   end

end
