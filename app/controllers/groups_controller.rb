class GroupsController < ApplicationController
 
  before_filter :authenticate_user!
  load_and_authorize_resource
  
 
  def index
     @owned_groups = Group.where(:user_id => current_user.id)
     @joined_groups = Group.where('id in (?) ',current_user.joined_groups.map(&:user_id))
   
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @owned_groups }
      format.json  { render :json => @joined_groups }
    end
  end
 
  def invite
    @group = Group.find(params['group_id'])
    if is_member(current_user.id,@group.id) 
          @invitation = Invitation.new(params[:invitation])
          @invitation.user_id = current_user.id
          @invitation.reason = "join group "+@group.name
          respond_to do |format|
           if @invitation.save
              format.html  { redirect_to(invitations_url, :notice => 'invitation successfully sent!') }
              format.json  { head :no_content }
            else
              format.html  { redirect_to invitations_url, :error => 'failed to send invitation' }
              format.json  { render :json => @invitation.errors, :status => :unprocessable_entity }
            end
          end
    else
       respond_to do |format|
          format.html  { redirect_to invitations_url, :notice => 'you must be a member to send invitations' }
          format.json  { head :no_content, :notice => 'you must be a member to send invitations'}
       end
    end   
 
    @group = Group.find(params['group_id'])
    @grupmember = GroupMember.create(:user_id=>current_user.id,:group_id=>@group.id,:role=>'Member',:join_date=>DateTime.now)
      respond_to do |format|
        format.html  { redirect_to(request.referer, :notice => 'You have joined successfully this group.') }
        format.json  { render :json => @grupmember, :status => :created, :location => @grupmember }
      end
 
  end
  
  def join
    @group = Group.find(params['group_id'])
    @grupmember = GroupMember.create(:user_id=>current_user.id,:group_id=>@group.id,:role=>'Member',:join_date=>DateTime.now)
      respond_to do |format|
        format.html  { redirect_to(request.referer, :notice => 'You have joined successfully this group.') }
        format.json  { render :json => @grupmember, :status => :created, :location => @grupmember }
      end
 
  end
  
  def leave
    @group = Group.find(params['group_id'])
    @groupmember = GroupMember.where(:user_id=>current_user.id,:group_id=>@group.id)
    @groupmember.each do |member|
      member.destroy
    end
      respond_to do |format|
        format.html  { redirect_to(request.referer, :notice => 'You have left this group.') }
        format.json  { render :json => @groupmember, :status => :destroyed, :location => @groupmember }
      end
 end
 
 def show
    @group_member = GroupMember.new
    @invitation = Invitation.new
    @groups = Group.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @invitation }
      format.json  { render :json => @groups }
    end
  end

  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @group }
    end
  end

  def edit
      @group = Group.find(params[:id])
  end

  def create
      @group = Group.new(params[:group])
      @group.user_id = current_user.id
      @group.creation_date = DateTime.now
      @group.founder = current_user.nickname
      @group.admins = 1
    
      respond_to do |format|
      if @group.save
        @group.group_members.create!(:user_id=>current_user.id,:group_id=>@group.id,:join_date=>DateTime.now,:role=>"Owner and Founder")
        format.html  { redirect_to('/groups', :notice => 'group was successfully created.') }
        format.json  { render :json => @group, :status => :created, :location => @group }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
    if @group.update_attributes(params[:group])
      format.html  { redirect_to(@group, :notice => 'group was successfully updated.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @group.errors, :status => :unprocessable_entity }
    end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
       format.html { redirect_to request.referer }
       format.json { head :no_content }
    end
  end
 
end

