class PartnersController < ApplicationController
  
    

  def index
     @partners  = Staff.all
      respond_to do |format|
      format.html
      format.json  { render :json => @partners }
     end
  end

  
end
