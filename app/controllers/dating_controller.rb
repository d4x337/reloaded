class DatingController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "reloaded"

  def profile

  end

  def swipe

  end

  def radar

  end

  def guests

  end

  def likes

  end

  def matches

  end

  def chat

  end
end
