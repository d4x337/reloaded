class ShadowController < ApplicationController

  before_filter :authenticate_user!

  def index
    @shadows = Shadow.all
  end



  def destroy
    @shadow = Shadow.find(params[:id])

    if @shadow.destroy
      render json: { message: "Message deleted" }
    else
      render json: { message: Shadow.errors.full_messages.join(',') }
    end
  end

  private
  def shadow_params
    params.require(:shadow).permit(:sender_id,:sender_email,:content,:recipient_id,:recipient_email)
  end

end
