class IncomesController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "dashboard"

  def index
   if (current_user.role? :admin) or (current_user.role? :master)
    @incomes = Income.where(:user_id=>0).order(:created_at).reverse_order
   elsif (current_user.role? :cpr) or (current_user.role? :pr) or (current_user.role? :prj)
    @incomes = Income.where(:user_id=>current_user.id).order(:created_at).reverse_order
   end
  
      respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @incomes }
     end
  
  end

end
