module ApplicationHelper
 
  TIME_PATTERN = {'s'=>'',' hour'=>'h', ' minute'=>'m', ' day'=>'d', ' hours'=>'h', ' minutes'=>'m', ' days'=>'d'}

  def is_banned(current_user_id,other_user_id)
    if current_user.blocked_users.map(&:blocked_id).include? other_user_id
      return true
    else
      return false
    end
  end

  def fire_notification_all_connections(user_id,reason)
    @user = User.find(user_id)
    @connections = @user.friends

  end

  def already_requested_and_not_answered(user_id,friend_id)
    @request = Request.where(:user_id=>user_id,:target_id=>friend_id,:status=>'PENDING',:answered=>false).count
    if @request > 0
      return true
    else
      return false
    end
  end
  
  def have_to_show_status(current_user_id,other_user_id)
    @current_user = User.find(current_user_id)
    @other_user = User.find(other_user_id)
    
    if @other_user.status_privacy == 0
      return true
    elsif @other_user.status_privacy == 1
      if is_in_other_user_contacts(other_user_id,current_user_id)
        return true
      else
        return false
      end
    elsif @other_user.status_privacy == 2
      return false
    end 
  end

  def have_to_show_last_access(current_user_id,other_user_id)
    @current_user = User.find(current_user_id)
    @other_user = User.find(other_user_id)
    
    if @other_user.last_access_privacy == 0
      return true
    elsif @other_user.last_access_privacy == 1
      if is_in_other_user_contacts(other_user_id,current_user_id)
        return true
      else
        return false
      end
    elsif @other_user.last_access_privacy == 2
      return false
    end 
  end

 def have_to_show_photo(current_user_id,other_user_id)
    @current_user = User.find(current_user_id)
    @other_user = User.find(other_user_id)
    
    if @other_user.picture_privacy == 0
      return true
    elsif @other_user.picture_privacy == 1
      if is_in_other_user_contacts(other_user_id,current_user_id)
        return true
      else
        return false
      end
    elsif @other_user.picture_privacy == 2
      return false
    end 
  end

 def have_to_show_email(current_user_id,other_user_id)
    @current_user = User.find(current_user_id)
    @other_user = User.find(other_user_id)
    
    if @other_user.email_privacy == 0
      return true
    elsif @other_user.email_privacy == 1
      if is_in_other_user_contacts(other_user_id,current_user_id)
        return true
      else
        return false
      end
    elsif @other_user.email_privacy == 2
      return false
    end 
  end

  def time_ago_in_words_converter(time)
    word = time_ago_in_words(time)
    TIME_PATTERN.each_pair{ |k, v| word.gsub!(k, v) }
    word
  end

  def is_in_other_user_contacts(other_user_id,current_user_id)
    @user_contact = UserContact.where(:user_id=>other_user_id,:contact_id=>current_user_id).count
    if (@user_contact>0)
      return true
    else
      return false
    end
  end

  
  def is_contact(user_id,contact)
    @user_contact = UserContact.where(:user_id=>user_id,:contact_id=>contact).count
    if (@user_contact>0)
      return true
    else
      return false
    end
  end

  def get_user_contact(user_id,contact_id)
    return @user_contact = UserContact.where(:user_id=>user_id,:contact_id=>contact_id).first
  end
  
  def get_blocked_user(user_id,blocked_id)
    return @blocked_user = BlockedUser.where(:user_id=>user_id,:blocked_id=>blocked_id).first
  end
  

    def are_active_controllers(controller_names)
      result = ""
      controller_names.each do |c|
        params[:controller] == c ? "active" : nil
        result =  params[:controller] == c ? "active" : nil
        return result if result == "active"
      end
      result
    end
    
     def highest_role(user_id)
      @user = User.find(user_id)
      @privileges = ""
      if @user.role? :master
          @privileges = @privileges +" "+ "Master"
      end
      if @user.role? :admin
          @privileges =@privileges +" "+ "Admin"
      end
      if @user.role? :cpr
          @privileges =@privileges +" "+ "Capo PR"
      end
      if @user.role? :pr
          @privileges =@privileges +" "+ "PR"
      end
      if @user.role? :prj
          @privileges =@privileges +" "+ "PR Junior"
      end
      if @privileges == ""
        @privileges = "Member"
      end
      return @privileges
    end
    
    def is_active_action_controller(controller_name, action_name)
        return nil if controller_name != params[:controller]
        params[:action] == action_name ? "active" : nil
    end
    
    
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end
    
    def d4x_sanitizer(xobject)
    if xobject.class == Hash
        xobject.each do |key,value|
          if not value.blank?
              value = Sanitize.clean(value, Sanitize::Config::RESTRICTED)
              value = ActionController::Base.helpers.sanitize(value)
               #   CUSTOM_ENTRIES.each do |entry|
               #     if value.include? entry
               #     
               #     end 
               #   end
           end   
        end
    elsif xobject.class == String
        xobject = Sanitize.clean(xobject, Sanitize::Config::RESTRICTED)
        xobject = ActionController::Base.helpers.sanitize(xobject)
          # CUSTOM_ENTRIES.each do |entry|
          #    if xobject.include? entry
          #    end 
          #  end
    end
  end

  def user_liking(mini_post_id,user_id)
   @liking = MiniPostLiking.where(:user_id=>user_id,:mini_post_id=>mini_post_id,:liking=>true).first
    if @liking
      return @liking
    else
      return 0
    end   
  end
  
  def count_likes(id)
    @count = 0
    @count = MiniPostLiking.where(:mini_post_id=>id.to_i,:liking=>true).count
    return @count
  end

  def count_dontlikes(mini_post_id)
    @count = 0
    @count = MiniPostLiking.where(:mini_post_id=>mini_post_id,:liking=>false).count
    return @count
  end
  
  def count_favorites(mini_post_id)
    @count = 0
    @count = MiniPostFavorite.where(:mini_post_id=>mini_post_id,:favorite=>true).count
    return @count
  end
  
  def count_public_shares(mini_post_id)
    @count = 0
  #  @count = MiniPost.where(:mini_post_id=>mini_post_id,:shared=>true,:visibility=>'PUBLIC').count
    return @count
  end
  
  def count_lounge_shares(mini_post_id)
    @count = 0
   # @count = MiniPost.where(:mini_post_id=>mini_post_id,:shared=>true,:visibility=>'LOUNGE').count
    return @count
  end
  
   def count_comments(mini_post_id)
    @count = 0
    @count = MiniPostComment.where(:mini_post_id=>mini_post_id).count
    return @count
  end
  
  def user_likes(user_id,mini_post_id)
    bRet = false
    @found = MiniPostLiking.where(:user_id=>user_id,:mini_post_id=>mini_post_id,:liking=>true)
    if @found.present?
      bRet = true 
    end
    return bRet
  end
 
  def user_dislikes(user_id,mini_post_id)
    bRet = false
    @found = MiniPostLiking.where(:user_id=>user_id,:mini_post_id=>mini_post_id,:liking=>false)
    if @found.present?
      bRet = true 
    end
    return bRet
  end

  def user_has_shared_to_public(user_id,mini_post_id)
    bRet = false
    @found = MiniPost.where(:author_id=>user_id,:id=>mini_post_id,:visibility=>'PUBLIC')
    if @found.present?
      bRet = true 
    end
    return bRet
  end

  def user_has_shared_to_lounge(user_id,mini_post_id)
    bRet = false
    @found = MiniPost.where(:author_id=>user_id,:id=>mini_post_id,:visibility=>'PUBLIC')
    if @found.present?
      bRet = true 
    end
    return bRet
  end

  def user_has_commented(user_id,mini_post_id)
    bRet = false
    @found = MiniPostComment.where(:user_id=>user_id,:mini_post_id=>mini_post_id)
    if @found.present?
      bRet = true 
    end
    return bRet
  end

  def is_user_favorite(user_id,mini_post_id)
    bRet = false
    @found = MiniPostFavorite.where(:user_id=>user_id,:mini_post_id=>mini_post_id)
    if @found.present?
      bRet = true 
    end
    return bRet
  end

 def all_services(cart_id)
    bret = false
    @cart = Cart.find(cart_id)
    @cart.cart_products.each do |item|
       bret = true if not is_service(item.product_id)
    end   
    return bret
  end

  def get_setting_value(key)
    @option = Option.find_by_name(key)
    return @option.value
  end
  
  def is_service(prod_id)
    @product = Product.find(prod_id)
    if @product.category == "service"
      return true
    else 
      return false
    end
  end
  
  def is_product(prod_id)
    @product = Product.find(prod_id)
    if @product.category == "product"
      return true
    else 
      return false
    end  
  end
  
  def cart_products_count(cart_id)
    @cart = Cart.find(cart_id)
    @qty = 0
    @cart.cart_products.each do |item|
      @qty += item.quantity
    end  
    
    return @qty
  end
  
 def prod_name_by_code(product_id)
   @prod = Product.find(product_id)
   return @prod.name
 end
  
 def used_quota(dir_path)
   require 'find'
   size=0
   Find.find(dir_path){
     |f| size += File.size(f) if File.file?(f)
   }
   return size
 end 

 def product_name(prod_id)
   @prod = Product.find(prod_id)
   return @prod.description
 end 

 def remaining_quota(initial_quota,used_quota)
    remaining = 0
    remaining = initial_quota - used_quota
    return remaining
 end 

  
 def customername(id)
    @user = Order.find(id)
    return @user.first_name+" "+@user.last_name
  end
 
   def cr2br(s)
     s.gsub(/\n/,'<br>')
   end
   
  def totalorder(id)
    @user = Order.find(id)
    return @user.total
  end
 
  def emailaddress(id)
    @user = Order.find(id)
    return @user.email
  end

  def current_language
    xret = ""
    if params[:locale] == "it" 
      xret = "ITALIAN"
    elsif params[:locale] == "en"  
      xret = "ENGLISH"
    elsif params[:locale] == "nl"  
      xret = "DUTCH"
    elsif params[:locale] == "fr"  
      xret = "FRENCH"
    elsif params[:locale] == "es"  
      xret = "SPANISH"
    elsif params[:locale] == "pt"  
      xret = "PORTOGUESE"
    elsif params[:locale] == "tr"  
      xret = "TURKISH"
    elsif params[:locale] == "se"  
      xret = "SWEDISH"
    elsif params[:locale] == "cn"  
      xret = "CHINESE"
    elsif params[:locale] == "ru"  
      xret = "RUSSIAN"
    elsif params[:locale] == "de"  
      xret = "GERMAN"
    else 
      xret = " "
    end
    
    return xret
  end
 
  def user_language(short)
    xret = ""
    
    if short == "it" 
      xret = "ITALIAN"
    elsif short == "en"  
      xret = "ENGLISH"
    elsif short == "de"  
      xret = "GERMAN"
    elsif short == "fr"  
      xret = "FRENCH"
    elsif short == "es"  
      xret = "SPANISH"
    elsif short == "pt"  
      xret = "PORTOGUESE"
    elsif short == "tr"  
      xret = "TURKISH"
    elsif short == "se"  
      xret = "SWEDISH"
    elsif short == "cn"  
      xret = "CHINESE"
    elsif short == "ru"  
      xret = "RUSSIAN"
    elsif short == "nl"  
      xret = "DUTCH"
    else 
      xret = " "
    end
    
    return xret
  end
 
  def localize(ip_address)
     @intip = ip_address.to_i
     @block  =  IpBlock.find(:all,:conditions =>['block_start =< ? and block_end >= ?', @intip]).first
     return @block
   end
   
   def is_online(user_id)
     @online = Visitor.find(:all,:conditions =>['user_id = '+user_id.to_s+' and created_at > ?',5.minutes.ago]).count
     if @online > 0
       return true
     else
       return false
     end
   end  
   
  def is_member(user_id,group_id)
    @user = GroupMember.where(:user_id=>user_id,:group_id=>group_id)
    if @user
      return true
    else
      return false
    end
  end
  
  def last_member(group_id)
    @lastmember = GroupMember.where(:group_id=>group_id).order(:created_at).reverse_order.first
    if @lastmember
      @user = User.find(@lastmember.user_id)
      return @user.nickname
    else
      return "not available"
      
    end
  end
  
  def join_group(group_id,user_id)
    
    
  end
 
  def leave_group(group_id,user_id)
    
    
  end
 
  def group_posts(group_id)
    @group_members = Group.find(group_id)
    @posts = MiniPost.where(:group_id=>group_id)
    return @posts
  end
  
  def group_members(group_id)
    @group_members = GroupMember.find(group_id)
    @users = User.find(:all,:conditions =>['id in (?)',@group_members.map(&:user_id)])
  
    return @users
  end
   
  def is_product(prod_id)
      flag = false
      @product = Product.find(prod_id)
      if @product
        if @product.category == "product"
          flag = true
        end
      end
     return flag    
  end

  def current_user_cart(user_id)
     @cart = Cart.where(:user_id=>user_id).order(:id).reverse_order.limit(1).first
    return @cart    
  end

  def is_service(prod_id)
      flag = false
      @product = Product.find(prod_id)
        if @product.category == "service"
          flag = true
        end
      return flag    
  end

  def is_annual_subscription(prod_id)
      flag = false
      @product = Product.find(prod_id)
      if @product
        if @product.subscription == "Annual"
          flag = true
        end
      end
      return flag    
  end
  
  def cart_contains_products(cart_id)
      flag_product = false
      @cart = Cart.find(cart_id)
      @cart.each do |item|
        prod_id = xitem.prodoct_id
        @product = Product.find(prod_id)
        if @product
          if @product.category == "product"
            flag_product = true
          end
        end
      end
      return flag_product    
  end
     
  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.purchased_at
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  def user_joined_groups(user_id)
    @user = User.find(user_id)
    @joined_groups = Group.where('id in (?) ',@user.joined_groups.map(&:user_id))
  end

  def only_joined_groups(user_id)
    @user = User.find(user_id)
    @founded = Group.where(:user_id=>user_id)
    @joined_groups = Group.where('id in (?) and id not in (?)',@user.joined_groups.map(&:user_id),@founded.map(&:user_id))
  end
 
  def user_founded_groups(user_id)
    @groups = Group.where(:user_id=>user_id,:deleted=>false)
  end

  def is_you(user_id,friend_id)
    if (friend_id == user_id)
      return true
    else
      return false
    end
  end

  def is_friend(user_id,friend_id)
    @isfriend = Friend.where(:user_id=>user_id,:friend_id=>friend_id).count
    if (@isfriend>0)
      return true
    else
      return false
    end
  end
  
  def already_requested_and_not_answered(user_id,friend_id)
    @request = Request.where(:user_id=>user_id,:target_id=>friend_id,:status=>'PENDING',:answered=>false).count
    if @request > 0 
      return true
    else
      return false
    end
 end

  def my_posts_count(user_id)
    @mini_posts_count = MiniPost.where(:author_id=>current_user.id).count
    return @mini_posts_count
  end
  
  def new_requests(user_id)
    @new_reqs = Request.find(:all,:conditions => ['target_id ='+user_id+' and answered = false']).count
    
    return @new_reqs  
  end
   
  def d4x_time_ago(date)
    sret = ""
    if date.to_d < 3.days.ago
      sret = date.to_s
    else
      sret = time_ago_in_words(date)
    end
     return sret
  end

  def agadanga_changed_pass(account_id)
    @account = MailAccount.find(account_id)
    if not @account.updated_at.blank?
       @ref_date = @account.updated_at
    else
       @ref_date = @account.created_at
    end
    return time_ago_in_words(@ref_date)
  end 
  
  def days_changed_pass(user_id)
    @user = User.find(user_id)
    if not @user.updated_password_at.blank?
       @ref_date = @user.updated_password_at
    else
       @ref_date = @user.created_at
    end
    return time_ago_in_words(@ref_date)
  end



  def available_domains
     @domains = Domain.where(:active=>true)
     @domains = @domains.map(&:domain)
     return @domains
   end
   
   def user_fullname(user_id)
     @user = User.find(user_id)
     return @user.firstname
   end
   
   def user_nick(user_id)
     @user = User.find(user_id)
     return @user.nickname    
   end
   
   def invitation_is_accepted(invitation_id)
     #xuser = User.find_by_invitation_id(invitation_id)
     xuser = User.where(:invitation_id=>invitation_id).first
     
     if not xuser.blank?
        return t("accepted")
     else 
        return t("pending")
       
     end
     
   end
   
   def is_invited(token)
     if Invitation.where(:token=>token).count > 0
        return true
     else  
        return false
     end
   end
   
   def request_is_valid(token)
     whole_return = false
     @request = Request.find_by_token(token)
     if @request
        if @request.used_on.empty?
          @request.used_on = DateTime.now
          @request.last_operation = DateTime.now
          @request.save
          whole_return = true
        end      
     end
     return whole_return
   end
   
   def pr_parent_cpr(pr_id)
     @parentcpr = Staff.where(:pr_id=>pr_id,:relation=>"PR").first
     return @parentcpr
   end

   def prj_parent_pr(prj_id)
     @parentpr = Staff.where(:pr_id=>prj_id,:relation=>"PRJ").first
     return @parentpr
   end

   def prj_parent_cpr(prj_id)
     @parentcpr = Staff.where(:pr_id=>pr_id,:relation=>"PRJ").first
     return @parentcpr
   end
 
   def pr_prjs(pr_id)
      @prjs = Staff.where(:user_id=>pr_id,:relation=>"PRJ")
      return @prjs
   end
   
   def cpr_prs(cpr_id)
      @prs = Staff.where(:user_id=>pr_id,:relation=>"PR")
      return @prs
   end
   
   def get_token_email(token)
     return Invitation.where(:token=>token).first.recipient_email
   end
   
    def get_token_name(token)
     return Invitation.where(:token=>token).first.subject
   end
   
   def get_token_email_for_requests(token)
     return Request.where(:token=>token).first.target_email
   end
   
    def get_token_name_for_requests(token)
     return Request.where(:token=>token).first.fullname
   end
    def tot_regs
       @totregs = User.all.count
       return @totregs
   end  
    
   def is_friend(current_user_id,friend_id)
     @friend = Friend.where(:user_id=>current_user_id, :friend_id=>friend_id).count
     if @friend > 0
       return true
     else
       return false
     end
   end  
   
   def qotd
       @quanti  =  Quote.find(:all,:conditions =>['visible = true and approved = true and last_seen > ?', Date.yesterday]).count
       if (@quanti == 0)
           @found  =  Quote.find(:all,:conditions =>['visible = true and approved = true and last_seen < ?', 60.days.ago])
           if not @found.blank?
             @choosen_quote = @found.first
             @found.first.update_attributes(:last_seen=>DateTime.now)
             
           end
       else
           @choosen_quote = Quote.find(:all,:conditions =>['visible = true and approved = true and last_seen > ?', Date.yesterday]).first
       end
       
       return @choosen_quote 
   end
   
   
   def qotd2
     @choosen_quote = Quote.find(:all,:conditions =>['visible = true and approved = true and last_seen > ?', Date.yesterday]).first
     if @choosen_quote.blank?
        @found  =  Quote.find(:all,:conditions =>['visible = true and approved = true and last_seen < ?', 60.days.ago])
        if not @found.blank?
           @choosen_quote = @found.first
           @found.first.update_attributes(:last_seen=>DateTime.now)
         end
     end
     return @choosen_quote    
   end
   
   def qotd3
      @quotes = Quote.where(:visible=>true).limit(5)
     return @quotes     
   end
   
   def qotd4
      @quotes = Quote.where(:visible=>true).limit(1)
     return @quotes     
   end
   
   def online_friends(user_id)
     @friendsonline = User.find(:all,:conditions =>['id in (?)',user_id.friends.map(&:friend_id)],:order=>:nickname)
     return @friendsonline
   end
   
   def users_without_uberbox
     @uberusers = MailAccount.all
     @users   = User.find(:all,:conditions =>['id not in (?)',@uberusers.map(&:user_id)],:order=>:nickname)
     @users = @users.map(&:nickname)
     return @users
   end
   

   
   def available_domains
     @domains = Domain.where(:active=>true)
     @domains = @domains.map(&:domain)
     return @domains
   end
   
   def user_nick(user_id)
     @user = User.find(user_id)
     return @user.nickname    
   end
 
   def post_for_homepage?
     if Post.where(:pinged=>'h0m3p4g3').count > 0
        return true
     else  
        return false
     end
   end
   
   def invitation_is_accepted(invitation_id)
     #xuser = User.find_by_invitation_id(invitation_id)
     xuser = User.where(:invitation_id=>invitation_id).first
     
     if not xuser.blank?
        return t("accepted")
     else 
        return t("pending")
       
     end
     
   end
   
   def is_invited(token)
     if Invitation.where(:token=>token).count > 0
        return true
     else  
        return false
     end
   end
   
   def get_token_email(token)
     return Invitation.where(:token=>token).first.recipient_email
   end
   
    def get_token_name(token)
     return Invitation.where(:token=>token).first.subject
   end
   
   
   def has_new_messages(user_id)
     user = User.find(user_id)
     if user.mail_accounts.blank?
       return false
     else
           maildir = Maildir.new(user.mail_accounts.first.home+"/"+user.mail_accounts.first.maildir,false)
           @count_new = maildir.list(:new).count
           if (@count_new > 0)
             return true
           else
             return false 
           end
      end     
   end
   
   def count_new_messages(user_id)
     @count_new = 0
     user    = User.find(user_id)
     maildir = Maildir.new(user.mail_accounts.first.home+"/"+user.mail_accounts.first.maildir,false)
     @count_new = maildir.list(:new).count if maildir.list(:new).count > 0 
     return @count_new
   end
  
  def homepagepost
    @post = Post.where(:pinged=>'h0m3p4g3')
  end  
  
   def nickname_taken(nickname)
      @many = User.where(:nickname => params[:nickname]).count
      if @many > 0
          return true
       else
          return false
      end
   end
   
   def liked_or_disliked(mini_post_id)
        feed = MiniPostLiking.where(:user_id => current_user.id,:mini_post_id => mini_post_id)
        if (feed.first.liking.eql? true)
          return "liked"    
        else
          return "disliked"    
        end
   end
   
   def comment_liked_or_disliked(comment_id)
        feed = MiniPostCommentLiking.where(:user_id => current_user.id,:mini_post_comment_id => comment_id)
        if (feed.first.liking.eql? true)
          return "liked"    
        else
          return "disliked"    
        end
   end
   
   
    def user_feed(mini_post_id)
     html = ""
         feed = MiniPostLiking.where(:user_id => current_user.id,:mini_post_id => mini_post_id)
         if (feed.first.liking.eql? true)
             html << image_tag("like14.png", :id => "liked", :name => "liked",:size => "16x16", :class => "bullet")
             html << '<span id="liked">'
             html << t('you like this post')
             html << ' </span>'
            
         else
             html << image_tag("dislike14.png", :id => "disliked", :name => "disliked",:size => "16x16", :class => "bullet")
             html << '<span id="disliked">'
             html << t('you dont like this post')
             html << '</span>'
           
         end
     return raw(html)  
   end
   
   def user_feed_comm(mini_post_comment_id)
     html = ""
         feed = MiniPostCommentLiking.where(:user_id => current_user.id,:mini_post_comment_id => mini_post_comment_id)
         if (feed.first.liking.eql? true)
             html << image_tag("like14.png", :id => "liked", :name => "liked",:size => "16x16", :class => "bullet")
             html << '&nbsp;'
             html << t('you like this post')
         else
             html << image_tag("dislike14.png", :id => "disliked", :name => "disliked",:size => "16x16", :class => "bullet")
             html << t('you dont like this post')
         end
     return raw(html)  
   end
   
   def user_added_sensation(mini_post_id)
     howmany = MiniPostFeed.where(:user_id => current_user.id,:mini_post_id => mini_post_id).count
     added = false
     if (howmany.eql? 0)
         added = false  
     else (howmany.eql? 1)
         added = true
     end 
     return added  
   end
   
   def how_many_this_sensation(mini_post_id,feedtag)
      howmany = MiniPostFeed.where(:feedtag => feedtag,:mini_post_id => mini_post_id).count
      return howmany
   end
   
   
   def user_sensation_tag(mini_post_id,user_id)
      @feed = MiniPostFeed.where(:user_id => user_id,:mini_post_id => mini_post_id).first
      if @feed
        return @feed.feedtag
      end
   end
   
   def user_has_voted(mini_post_id)
     howmany = MiniPostLiking.where(:user_id => current_user.id,:mini_post_id => mini_post_id).count
     voted =false
     if (howmany.eql? 0)
         voted = false  
     else (howmany.eql? 1)
         voted =true
     end 
     return voted  
   end
   
   def user_has_voted_comm(mini_post_comment_id)
     howmany = MiniPostCommentLiking.where(:user_id => current_user.id,:mini_post_comment_id => mini_post_comment_id).count
     voted =false
     if (howmany.eql? 0)
         voted = false  
     else (howmany.eql? 1)
         voted =true
     end 
     return voted  
   end

  def user_tot_likes(user_id)
    html = ""
    likes = MiniPostLiking.where(:user_id => user_id, :liking => true).count
    #html << likes.to_s+ " "
    if (likes.eql? 0)
      html << "0"
    else
      html << likes.to_s
    end
    raw(html)
  end

  def user_tot_favorites(user_id)
    html = ""
    likes = MiniPostFavorite.where(:user_id => user_id, :favorite => true).count
    if (likes.eql? 0)
      html << "0"
    else
      html << likes.to_s
    end
    raw(html)
  end

   def mp_tot_likes(mini_post_id)
       html = ""
       likes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => true).count
       #html << likes.to_s+ " "
       if (likes.eql? 0) 
         html << t('no likes')
       else
         html << likes.to_s
         html << " "
         if (likes.eql? 1) 
           html << t('like')
         else 
            html << t('likes') 
         end
       end  
       html << "  -  " 
       raw(html)
   end
   
   def tot_dislikes_evo(mini_post_id)
        html = " - "
        dislikes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => false).count
         html << image_tag("dislike14.png",:id => "feed-icon",:class=>"bullet")
         html << " "
         html << dislikes.to_s
        raw(html)
   end
   
    def tot_likes_evo(mini_post_id)
        html = ""
        likes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => true).count
         html << image_tag("like14.png",:id => "feed-icon",:class=>"bullet")
         html << " "
         html << likes.to_s
        raw(html)
   end
   
   def tot_dislikes_13(mini_post_id)
        html = " - "
        dislikes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => false).count
         html << image_tag("dislike14.png",:id => "feed-icon",:class=>"bullet comment-header")
         html << " "
         html << dislikes.to_s
         html << t(" people dislike this")
        raw(html)
   end
   
   def tot_feeds_14(mini_post_id)
   
   end
   
   def at_least_one_like_or_one_dislike(mini_post_id)
     count = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => true).count
     if (count == 0)
      return false;
     else
      return true;   
     end
   end
   
    def tot_likes_13(mini_post_id)
        html = ""
        likes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => true).count
         html << " "
         if (likes == 0)
           html << t("be the first to add your feedback")
         elsif (likes==1)
           html << image_tag("like14.png",:id => "feed-icon",:class=>"bullet comment-header")
           html << '&nbsp;'
           html << likes.to_s
           html << '&nbsp;'
           html << t("person likes this")
         else
           html << image_tag("like14.png",:id => "feed-icon",:class=>"bullet comment-header")
           html << '&nbsp;'
           html << likes.to_s
           html << '&nbsp;'
           html << t("people like this")
         end
        
        raw(html)
   end
   
   def tot_dislikes_13(mini_post_id)
          html = ""
         likes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => true).count
         html << " "
         if (likes == 0)
           html << t("be the first to add your feedback")
         elsif (likes==1)
           html << image_tag("dislike14.png",:id => "feed-icon",:class=>"bullet comment-header")
           html << '&nbsp;'
           html << likes.to_s
           html << '&nbsp;'
           html << t("person dislikes this")
         else
           html << image_tag("dislike14.png",:id => "feed-icon",:class=>"bullet comment-header")
           html << '&nbsp;'
           html << likes.to_s
           html << '&nbsp;'
           html << t("people dislike this")
         end
        
        raw(html)
   end

   
   def mp_tot_dislikes(mini_post_id)
        html = ""
        dislikes = MiniPostLiking.where(:mini_post_id => mini_post_id, :liking => false).count
       # html << dislikes.to_s+" "
        if (dislikes.eql? 0) 
          html << t('no dislikes')
        else
         html << dislikes.to_s
         html << " "
         if  (dislikes.eql? 1) 
           html << t('dislike')
         else 
           html << t('dislikes') 
         end
       end
       raw(html)
   end
   
   def mp_tot_comments(mini_post)
        html = " - "
       if (mini_post.mini_post_comment.count.eql? 0) 
            html << t('no comments')
        else
           html << t('comments')
           html << " "
           html << mini_post.mini_post_comment.count.to_s
        end
       raw(html)
   end
  
   
   def tot_comments_evo(mini_post)
        html = " - "
         html << image_tag("comments.png",:id => "feed-icon",:class=>"bullet")
         html << " "
         html << mini_post.mini_post_comment.count.to_s
        raw(html)
   end
   
   def post_comment_actions(mini_post_id)
     
     mini_post = MiniPost.find(mini_post_id)
     html = ""
     if (mini_post.mini_post_comment.count.eql? 0)
     elsif  (mini_post.mini_post_comment.count.eql? 1)
           html << link_to(t("view comment"), mini_post)
           html << '('+
           html << mini_post.mini_post_comment.count.to_s
           html << ')'
     elsif  (mini_post.mini_post_comment.count.eql? > 1)
           html << link_to(t("view comments"), mini_post)
           html << '('+
           html << mini_post.mini_post_comment.count.to_s
           html << ')'
      end
      html << link_to(t("add comment"), mini_post)
      raw(html)
   end
   
   def post_comment_likes(mini_post_comment)
   end
  
   def post_comment_dislikes(mini_post_comment)
     
   end
   
   def is_a_like(mini_post_id)
      feed = MiniPostLiking.where(:user_id => current_user.id,:mini_post_id => mini_post_id).first
      if  feed.liking = true
        return true      
      else
        return false
      end
   end
   
   def cr2br(s)
     s.gsub(/\n/,'<br>')
   end

end
