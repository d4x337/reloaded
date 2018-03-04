class IpostsController < ApplicationController
  def index
    get_and_show_posts
  end

  def index_with_button
    get_and_show_posts
  end

  def show
    @ipost = Ipost.find_by_id(params[:id])
  end

  private

  def get_and_show_posts
    @iposts = Ipost.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

end