class ChatController < ApplicationController

  before_filter :authenticate_user!, :set_arrays
  protect_from_forgery with: :null_session
   
  def index
      @chats = Chat.where('sender_id = (?) or target_id = ? and sender_id != target_id',current_user.id,current_user.id).order(:created_at).reverse_order
   
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @chats }
      end
  end
  
  def chat_heartbeats
    items = []
    Chat.find(:all, :conditions => {:to => current_user.nickname, :recd => 0}, :order => 'id ASC').each do |chat|
      items = session[:chat_history][chat.from] if session[:open_chat_boxes][chat.from].nil? and session[:chat_history][chat.from]
      items << {:s => 0, :f => chat.from, :m => chat.message}
      session[:chat_history][chat.from] = [] if session[:chat_history][chat.from].nil?
      session[:chat_history][chat.from] << {:s => 0, :f => chat.from, :m => chat.message}
      session[:ts_chat_boxes][chat.from] = nil
      session[:open_chat_boxes][chat.from] = chat.sent
      chat.recd = 1
      chat.save!
    end
    if !session[:open_chat_boxes].empty?
      session[:open_chat_boxes].each do |chatbox, value|
        if session[:ts_chat_boxes][chatbox].nil?
          if not value.blank?
            time = DateTime.parse(value.to_s)
            now = (DateTime.now - time) * 86400
            stime = time.strftime("%I:%MAM %b #{time.day.ordinalize}")
         
            message = "Sent at #{stime}"
            if now > 180
              items << {:s => 2, :f => chatbox, :m => "{#{message}}"}
              session[:chat_history][chatbox] = [] if session[:chat_history][chatbox].nil?
              session[:chat_history][chatbox] << {:s => 2, :f => chatbox, :m => "{#{message}}"}
              session[:ts_chat_boxes][chatbox] = 1;
            end
          end  
        end
      end
    end
    render :json => {:items => items}.to_json
  end
 
  def start_chat_session
    items = []
    if !session[:open_chat_boxes].empty?
      session[:open_chat_boxes].each do |chatbox, item|
        items += chat_box_session(chatbox)
      end
      render :json => {:username => current_user.nickname, :items => items}.to_json 
    else
      session[:online_friends_count] = User.where(:id => current_user.friends.map(&:friend_id),:chat_status=>1).count
      session[:friends_list] = User.where(:id => current_user.friends.map(&:friend_id))
      if !session[:friends_list].empty?
          chat_room = session[:friends_list]
      end
   
      if (session[:online_friends_count]>0)
          online_count = session[:online_friends_count]
      end
      @list =  User.where(:id => current_user.friends.map(&:friend_id))
      items = @list.to_json(:only =>[:nickname,:avatar_file_name,:chat_status,:on_mobile])
            
      if (current_user.chat_status == '1')
        status = 'online'
      else
        status = 'offline'
      end
      
      render :json => {:status=>status,:online => online_count, :username => current_user.nickname, :items => items} 
    end
  end
  
  def load_chat_list

      items = []
      # improvement - limit selection to those fields are useful.
      @chat_on_friends =  User.where(:id => current_user.friends.map(&:friend_id),:chat_status=>1)
      count_available = 0
      @chat_on_friends.each do |user|
          count_available=+1 if user.online?
      end
      session[:online_friends_count] = count_available

      session[:friends_list] = User.where(:id => current_user.friends.map(&:friend_id))
      
      if !session[:friends_list].empty?
          chat_room = session[:friends_list]
      end
      
      @list = User.where(:id => current_user.friends.map(&:friend_id)).order(:nickname)
   
     # @list = User.find(:all,:conditions =>['id = '+current_user.id.to_s+' and id in (?)',current_user.friends.map(&:friend_id)]).order(:nickname)
   
      i = 0
      tot_items = ""
      xitem = ""
      @list.each do |user|
          xitem = user.nickname+";"+user.avatar.url+";"+user.on_mobile.to_s+";"+user.online?.to_s+"|"
          i=i+1
          tot_items=tot_items+xitem;
      end
    
      xitem = current_user.nickname+";"+current_user.avatar.url+";"+current_user.on_mobile.to_s+";"+current_user.chat_status.to_s+"|"
      tot_items=tot_items+xitem;
      
      status = current_user.chat_status
      if status == 1
        count_available = count_available+1
      end
     
      render :json => {:status=>status, :online => count_available, :username => current_user.nickname, :tot_items=>tot_items}
  end
  
  def send_chat
    from = current_user.nickname
    from_id = current_user.id
    to = params[:to]
    @target = User.where(:nickname=>to).first
    target_id = @target.id
    message = params[:message]
    session[:open_chat_boxes][to] = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    #messagesan = sanitize(message)
    session[:chat_history][to] = [] if session[:chat_history][to].nil?
    session[:chat_history][to] << {:s => 1, :f => "{#{to}}", :m => "#{message}"}
    session[:ts_chat_boxes][to] = nil
    Chat.create(:sender_id=>from_id,:target_id=>target_id,:from => from, :to => to, :message => message, :sent => DateTime.now)
    render :text => 1
  end
  
  def close_chat
    session[:open_chat_boxes][params[:chatbox]] = nil
    render :text => 1
  end
  
  def set_status()
      @status_id = params['ccc']
      if @status_id.present?
        @user = User.find(current_user.id)
        @user.chat_status = @status_id
        @user.save
        render :text => @status_id
       end
  end
  
  def show
    @action = params[:id]
    @id=params['_']
    
    if not @id.blank?
      
      if @action == 'start_chat_session'
         start_chat_session
      elsif @action == 'chat_heartbeat'
         chat_heartbeat
      end
    else
      if @action == 'send_chat'
         send_chat
      elsif @action == 'load_chat_list'
         load_chat_list
      elsif  @id == 'close_chat'
         close_chat
      elsif  @action== 'set_status'
          set_status 
      else
          @chat = Chat.find(params[:id])
          respond_to do |format|
            format.html # show.html.erb
            format.json  { render :json => @chat }
          end
       end
    end
  end

  def new
    @chat = Chat.new
    @currentid = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @chat }
    end
  end

  def edit
    @chat = Chat.find(params[:id])
  end
   
  def new
    @chat = Chat.new
  end
  
  def create
      @chat = Chat.new(params[:chat])
      @chat.sender_id = current_user.id
      @chat.delivered = true
      respond_to do |format|
       if @chat.save
          format.html  { redirect_to(chats_url, :notice => 'message sent') }
          format.json  { head :no_content }
        else
          format.html  { redirect_to chats_url, :alert => 'failed to send message' }
          format.json  { render :json => @chat.errors, :status => :unprocessable_entity }
        end
      end
  
  end

  def update
    @chat = Chat.find(params[:id])
    respond_to do |format|
      if @chat.update_attributes(params[:chat])
        format.html  { redirect_to(@chat, :notice => 'message updated successfully.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @chat.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  @chat = Chat.find(params[:id])
  @chat.destroy
    respond_to do |format|
       format.html { redirect_to chats_url }
       format.json { head :no_content }
    end
  end

  private
  def chat_box_session(chatbox)
    return session[:chat_history][chatbox] if session[:chat_history][chatbox]
    return []
  end
  
  def set_arrays
    session[:chat_history] = Hash.new if session[:chat_history].nil? 
    session[:open_chat_boxes] = Hash.new if session[:open_chat_boxes].nil?
    session[:ts_chat_boxes] = Hash.new if session[:ts_chat_boxes].nil?

    session[:online_friends_count] = Hash.new if session[:online_friends_count].nil?
    session[:friends_list] = Hash.new if session[:friends_list].nil?
  end
   
end

