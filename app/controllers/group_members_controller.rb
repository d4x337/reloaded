class GroupMembersController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    @group_member = @group.group_member.create(:user_id=>current_user.id,:group_id=>@group.id,:role=>'Member')
    redirect_to(request.referer,:notice => 'Successfully Joined Group')
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    if (@comment.user_id == current_user.id)
      @comment.destroy
       redirect_to(request.referer,:notice => 'You have left this Group')
    else
    end
  end


end
