class LinksController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'dashboard'

	attr_accessible :url,
									:name,
									:image_file_name,
									:image_content_type,
									:image_file_size,
									:target,
									:description,
									:current_pos,
									:last_pos,
									:trend,
									:user_id,
									:visible,
									:rating,
									:rss,
									:notes
   
	def index
      if current_user.role? :author
        @links = Link.paginate(:page => params[:page])
      else
        @links = Link.where(:visible => 'Y').paginate(:page => params[:page])
      end
      respond_to do |format|
			format.html # index.html.erb
			format.json  { render :json => @links }
		end
	end
	
	def admin
       if current_user.role? :author
        @links = Link.paginate(:page => params[:page])
      else
        @links = Link.where(:visible => 'Y').paginate(:page => params[:page])
      end
       respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @links }
    end
  end
  
	 def box
     #@things = current_user.things
     @links = Link.where(:visible => 'Y').paginate(:page => params[:page])
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @links }
    end
  end
  
	 def list
     #@things = current_user.things
     @links = Link.where(:visible => 'Y')
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @links }
    end
  end
	
	def top
      @links = Link.where(:visible => 'Y').limit(15).order(:rating,:name)
  #  @links_grid = initialize_grid(Link,:order => 'tasks.title',  :order_direction => 'desc',:per_page => 40)
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @links }
    end
  end


	def show
		@link = Link.find(params[:id])
	#	@tags = @link.link_tag;
		respond_to do |format|
		  format.html # show.html.erb
		  format.json  { render :json => @links }
		#  format.json  { render :json => @tags }
		end
	end

	def new
		@link = Link.new
		@currentid = current_user.id
		respond_to do |format|
		  format.html # new.html.erb
		  format.json  { render :json => @links }
		end
	end

	def edit
		@link = Link.find(params[:id])
	end

	def create
		@link = Link.new(links_params)
    @link.user_id = current_user.id
  #  @tags_ids = params[:link][:tags].delete_if{ |x| x.empty?}
		
		respond_to do |format|
			if @link.save
			#   @tags_ids.each do |ids|
      #      @link.link_tag.create(:link_id => @link.id, :tag_id => ids)  
      #   end
			  format.html  { redirect_to(links_url, :notice => 'link was successfully created.') }
			  format.json  { render :json => @link, :status => :created, :location => @link }
 			else
			  format.html  { render :action => "new" }
			  format.json  { render :json => @link.errors, :status => :unprocessable_entity }
			end
		end
	end

	def update
	  @link = Link.find(params[:id])
	#  @tags_ids = params[:link][:tags].delete_if{ |x| x.empty?}

  #  @link.link_tag.delete_all
  #  @tags_ids.each do |ids|
  #       @link.link_tag.create(:link_id => @link.id, :tag_id => ids)  
  #  end
    
	  respond_to do |format|
		if @link.update_attributes(params[:link])
		  format.html  { redirect_to(links_url, :notice => 'link was successfully updated.') }
		  format.json  { head :no_content }
		else
		  format.html  { render :action => "edit" }
		  format.json  { render :json => @link.errors, :status => :unprocessable_entity }
		end
	  end
	end

	def destroy
	@link = Link.find(params[:id])
	@link.destroy
		respond_to do |format|
		   format.html { redirect_to links_url }
		   format.json { head :no_content }
		end
	end

	def links_params
		params.fetch(:link,{}).permit(:utf8,:url,
																										:name,
																										:image_file_name,
																										:image_content_type,
																										:image_file_size,
																										:target,
																										:description,
																										:current_pos,
																										:last_pos,
																										:trend,
																										:user_id,
																										:visible,
																										:rating,
																										:rss,
																										:notes)
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
