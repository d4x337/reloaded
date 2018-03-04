class FeedbacksController < ApplicationController

	before_filter :authenticate_user!, :except => [:new,:create,:send]


	def index
		if current_user.role? :author
			@feedbacks = Feedback.paginate(:page => params[:page])
		else
			@feedbacks = Feedback.where(:visible => true).paginate(:page => params[:page])
		end
		respond_to do |format|
			format.html
			format.json  { render :json => @feedbacks }
		end
	end


	def show
		@feedback = Feedback.find(params[:id])
		respond_to do |format|
			format.html
			format.json  { render :json => @feedback }
		end
	end

	def new
		@feedback = Feedback.new
		respond_to do |format|
			format.html # new.html.erb
			format.json  { render :json => @feedbacks }
		end
	end

	def edit
		@feedback = Feedback.find(params[:id])
	end

	def create
		@feedback = Feedback.new(:from=>params['name'],:email=>params['email'],:reason=>params['msg_subject'],:message=>params['message'])
		@feedback.sent_at = DateTime.now
		@feedback.ip = request.env['REMOTE_ADDR']
		if @feedback.save
			render json: { message: "success" }, :status => 200
		else
			render json: { error: @feedback.errors.full_messages.join(',')}, :status => 418
		end
	end

	def update
		@feedback = Feedback.find(params[:id])
		respond_to do |format|
			if @feedback.update_attributes(params[:feedback])
				format.html  { redirect_to(feedbacks_url, :notice =>  t('feedback successfully updated')) }
				format.json  { head :no_content }
			else
				format.html  { render :action => "edit" }
				format.json  { render :json => @feedback.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@feedback = Feedback.find(params[:id])
		@feedback.destroy
		respond_to do |format|
			format.html { redirect_to feedbacks_url }
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

