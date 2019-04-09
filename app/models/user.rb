class User < ActiveRecord::Base

  ROLES = %w[master admin cpr pr prj]
  
  cattr_accessor :current_user

  after_create :create_mailbox,:do_backoffice,:is_invited,:create_blog,:create_mailbox
  
  devise  :database_authenticatable, :lockable, :registerable,:recoverable, :rememberable, :trackable, :timeoutable,:validatable,:omniauthable,
          #:lastseenable, :confirmable,:authentication_keys => [:nickname]
          :confirmable,:authentication_keys => [:nickname]
           
  attr_accessible :email_privacy, :picture_privacy, :status_privacy, :last_access_privacy, :global_search_privacy, :invitation_token, :invite_email,
  :show_email,:show_mobile,:show_last_access,:roles, :email, :password, :password_confirmation, :remember_me, :nickname, :login, :firstname,:lastname, :gender, :country, :birthday,:id, :photo, :approved,
  :locale,:theme, :invitation_token,:invitation,:invitation_attributes,:last_seen,:updated_password_at,:order_id,:headline,:homepage,:second_address,:avatar,:crop_x,:crop_y,:crop_w,:crop_h,:agatheme,
  :skype_id,:twitter_user,:facebook_user,:linkedin_url,:location,:mobile,:secret_answer,:statement, :relation_status,:order_id,:cover,:invitations_list, :payment,
  :coupon, :subscription_start, :subscription_end, :payed,:about,:instagram_id,:github_id, :quote,:background
  
  attr_accessor :login,:crop_x,:crop_y,:crop_w,:crop_h,:processing

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }  
  scope :online, lambda{ where("last_seen > ?", 5.minutes.ago)}
  
  has_attached_file :photo,:url => "/:class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :photo, :content_type =>['image/jpeg', 'image/png', 'image/gif']
 
  #has_attached_file :avatar, :style=>{ :original => "500x500>",:thumbnail=> "150x150#"},:url => "/:class/:attachment/:id/:basename.:extension", :processors => [:cropper]
  #validates_attachment_content_type :avatar, :content_type =>['image/jpeg', 'image/png', 'image/gif']
 
   has_attached_file :avatar, :styles => { :large => "300x300>",:thumb => "150x150>" }, :processors => [:cropper]
  validates_attachment  :avatar, :content_type => { :content_type => /\Aimage\/.*\Z/ }, :size => { :less_than => 5.megabyte }


  has_attached_file :cover, :url => "/:class/:attachment/:id/:basename.:extension", :processors => [:cropper]
  validates_attachment_content_type :cover, :content_type =>['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :invitations_list, :url => "/:class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :invitations_list, :content_type =>'text/plain'

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => :user_id

  has_many :contacts, :class_name => 'UserContact', :foreign_key => :user_id

  belongs_to :invitation,:autosave => true
 
  has_many :status,:class_name=>'Status',:foreign_key=>:user_id
  
  has_many :blocked_users,:class_name=>'BlockedUser',:foreign_key=>:user_id
  
  has_many :mini_post
  has_many :mini_post_comment,:foreign_key => :user_id
  has_many :mini_post_likings,:foreign_key => :user_id
  has_many :mini_post_favorites,:foreign_key => :user_id
  has_many :mini_post_comment_likings,:foreign_key => :user_id
  has_many :friends, :foreign_key => :user_id
  has_many :requests, :foreign_key => :target_id
  has_many :updates, :foreign_key => :target_id
  has_many :pictures, :foreign_key => :user_id


  has_many :mail_accounts, :foreign_key => :user_id

  has_one :blog, :foreign_key => :owner_id

  has_many :sent_messages,:class_name=>'Message',:foreign_key=>:sender_id
  has_many :received_messages,:class_name=>'Message',:foreign_key=>:target_id

  #has_many :pictures,:class_name=>'Picture',:foreign_key=>:target_id

 # validates :email ,:presence => true, :length => { :in => 8..100 },:format => { :with => /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i, :message => "This is not a valid address" }
 # validates :firstname ,:presence => true, :length => { :in => 3..50 },:format => { :with => /\A[a-zA-Z\s]+\z/, :message => "Only letters (and spaces) allowed for full name" }
 # validates_format_of :password, :with => /\A.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*\z/, 
 #                :message => "must be at least 8 characters, have one number, one capital letter and a special char",
 #                :if => Proc.new { |user| !user.password.blank? }
 # validates_format_of :email, :with =>/\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i,:message => 'this is NOT a valid address!',:allow_blank => false
  
 # validates_format_of :nickname, :with => /[\A0-9a-z\@._-]g/, :message => "Only letters, numbers and underscore, dot and - allowed for username",:allow_blank=>false
 
   after_update :reprocess_avatar, :if => :cropping?
   
   include PgSearch
   multisearchable :against => [:nickname,:firstname]
   
   pg_search_scope :partial_search,
   :against=> {
     :nickname => 'A',
     :firstname => 'B'
   },
   :using =>{
     :tsearch => {:prefix => true}
   }

  def after_database_authentication
    if self.two_factor_enabled
     # puts "2FA Enabled on "+self.mobile
    else
     # puts "2FA Disabled: Authenticated "
    end
  end 
  
 #def to_param
 #   nickname
 # end
  
  def send_two_factor_authentication_code
     # use Model#otp_code and send via SMS, etc.
    puts ">>>>>>>>>>>>>>> otp_secret_key: #{otp_secret_key}, otp_code: #{otp_code}"
  end

  def need_two_factor_authentication?(request)
     #request.ip != '127.0.0.1'
    not otp_secret_key.nil?
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["LOWER(nickname) = :value or LOWER(email) = :value", { :value=> login.downcase}]).first
    else
      where(conditions).first  
    end
  end

  def roles=(roles)  
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum  
  end  
  
  def roles  
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }  
  end  

  def role_symbols  
      roles.map(&:to_sym)  
  end  

  def online?
    updated_at > 10.minutes.ago  
  end

  def role?(role)  
    roles.include? role.to_s  
  end  

  def active_for_authentication? 
    super && approved?
  end 
  
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super 
    end 
  end
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_w.blank?
  end
  
  def reprocess_avatar
      return unless (cropping? && !processing)
      self.processing = true
      avatar.reprocess!
      self.processing = false
   end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end
  
  def invitation_token
    invitation.token if invitation
  end
  
  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
    
  private 
  def send_welcome_message
    begin  
      UserMailer.welcome_email(self).deliver
    rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
  end
  
  def set_invitation_limit
    self.invitation_limit = Option.where(:name => 'MEMBER_MAX_INVITATIONS').first.value
  end
  
  def check_invite_only_mode
     registrations_status = Option.where(:name=>'REGISTRATIONS_STATUS').first.value
     if (resistrations_status == "INVITE_ONLY")
        return true
     else
       return false  
     end
  end
  
  def grant_income
     if not self.invitation.blank?
       self.invitation.update_attributes(:accepted=>true,:read_at=>Time.now)
       Income.create(:user_id=>self.invitation.user_id,:income_id=>self.id,:order_id=>self.order.order_id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
     else
       Income.create(:user_id=>0,:income_id=>self.id,:order_id=>0,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
     end
  end

  def is_invited
     if not self.invitation.blank?
       self.invitation.update_attributes(:accepted=>true,:read_at=>Time.now)
       Friend.create(:user_id=>self.id,:friend_id=>self.invitation.user_id)
       Friend.create(:user_id=>self.invitation.user_id,:friend_id=>self.id)
       Update.create(:sender_id=>self.id,:target_id=>self.invitation.user_id,:reason=>t('your invitation has been accepted'))
     end
  end

  def create_blog
    @blog = Blog.create(:owner_id=>self.id,:title=>"Your Blog's Title", :motto=>"Your Blog's Description")
    @blog_settings = BlogSettings.create(:blog_id=>@blog.id)
  end

  def create_mailbox
    if Rails.env.production?
      @nick = self.nickname
      @domain = "reloaded.com"
      maildir = '/var/vmail'

      MailAccount.create(:user_id=>self.id,:login=>@nick+"@"+@domain,:defaultbox=>true,:name=>self.firstname,:password=>self.password,:home=>maildir,:maildir=>@domain+"/"+@nick+"/",:quota=>1000000000)
      @maildir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/",true)
      @sentdir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Sent",true)
      @draftdir   = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Drafts",true)
      @spamdir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Spam",true)
      @archivedir = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Archive",true)
      @trashdir   = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Trash",true)
      system "chown -R vmail "+maildir+"/"+@domain+"/"+@nick
      system "chmod -R 700 "+maildir+"/"+@domain+"/"+@nick
    end
  end

  def do_backoffice
 
  if self.order_id.present?
    @order = Order.find(self.order_id)
    @order.user_id = self.id
    @order.save!
    
    @cart = Cart.find(@order.cart_id)
    @cart.purchased_at = DateTime.now
    @cart.order_id = @order.id
    @cart.save!
    
    if not @cart.request_token.blank?
        @request = Request.find_by_token(@cart.request_token)
        #verify token integridy, validate it
        @role = @request.relation
    end
   
    if not @cart.invitation_token.blank?
       self.invitation.update_attributes(:accepted=>true,:read_at=>Time.now)
       @seller = User.find(self.invitation.user_id)
      
       @provvCPR = Partner.find_by_pr_type("CPR")
       @provvPR  = Partner.find_by_pr_type("PR")
       @provvPRJ = Partner.find_by_pr_type("PRJ")
       
       percCPR   = @provvCPR.income
       percPR    = @provvPR.income
       percPRJ   = @provvPRJ.income
     
       incomeCPR   = ((@order.total/100)*percCPR)
       incomePR    = ((@order.total/100)*percPR)
       incomePRJ   = ((@order.total/100)*percPRJ)
       
       @income5  = incomePRJ
       @income10 = incomePR
       @income20 = incomeCPR
       
       if @seller.role? :prj
         #Grant income to PRJ 5%
         Income.create(:user_id=>self.invitation.user_id,:income=>@income5,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
   
         @prj_parent_pr = prj_parent_pr(@seller.id)
         if not @prj_parent_pr.blank?
           #Grant income to PR 5%
           Income.create(:user_id=>@prj_parent_pr.user_id,:income=>@income5,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
   
           #parent PR has a parent CPR?
           @cpr_parent_pr = prj_parent_pr(@prj_parent_pr.user_id)
           if not @cpr_parent_pr.blank?
             #Grant income to CPR 10%
             Income.create(:user_id=>@cpr_parent_pr.user_id,:income=>@income10,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
             #Grant income to Gestione 10%
             Income.create(:user_id=>0,:income=>@income10,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
         else  
           @prj_parent_cpr = prj_parent_cpr(@seller.id)
           
           #check this for bugs (double parent jump with no pr in the middle)
           if not @prj_parent_cpr.blank?
             #Grant income to CPR 15%
             Income.create(:user_id=>@prj_parent_cpr.user_id,:income=>@income10+@income5,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
             #Grant income to Gestione 15% 
             Income.create(:user_id=>0,:income=>@income10+@income5,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
         end
         
         elsif @seller.role? :pr
           #Grant income to PR 10%
           Income.create(:user_id=>self.invitation.user_id,:income=>@income10,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           @cpr_parent_pr = cpr_parent_pr(@seller.id)
   
           if not @cpr_parent_pr.blank?
            #Grant income to CPR 10%
            Income.create(:user_id=>@cpr_parent_pr.user_id,:income=>@income10,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
            #Grant income to Gestione 10%
            Income.create(:user_id=>0,:income=>@income10,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
  
       elsif @seller.role? :cpr
         Income.create(:user_id=>self.invitation.user_id,:income=>@income20,:income_id=>self.id,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
       end
    else
       #Grant income to Gestione
       Income.create(:user_id=>0,:income_id=>self.id,:income=>@income20,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
    end
 
    #create invoice and payment for the next month, if already exists add new line and update total.

    if @role.present?
        Staff.create(:user_id=>@request.user_id,:pr_id=>self.id,:relation=>@role,:begin_of_relation=>DateTime.now,:end_of_relation=>DateTime.now)
        #no matter what package chooses a requested partner (CPR -> 5GB, PR-> 3GB, PRJ -> 1GB) 
        maildir = "/var/vmail"
        if @role == "PRJ"
            MailAccount.create(:user_id=>self.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>self.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'1000000000S')
            self.roles_mask = 16
        elsif @role == "PR"
            MailAccount.create(:user_id=>self.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>self.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'3000000000S')
            self.roles_mask = 8
        elsif @role == "CPR"
            MailAccount.create(:user_id=>self.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>self.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'5000000000S')
            self.roles_mask = 4
        end  
    else
        maildir = Option.find_by_name('MAILDIR_PATH').value
        @order.rows.each do |item| 
          @prod = Product.find(item.product_id)
          if @prod.category == 'service'
             @nick = item.nickname
             @domain = item.domain
         
             MailAccount.create(:user_id=>self.id,:login=>@nick+"@"+@domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>self.password,:home=>maildir,:maildir=>@domain+"/"+@nick+"/",:quota=>@prod.quota)

             @maildir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/",true)
             @sentdir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Sent",true)
             @draftdir   = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Drafts",true)
             @spamdir    = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Spam",true)
             @archivedir = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Archive",true)
             @trashdir   = Maildir.new(maildir+"/"+@domain+"/"+@nick+"/.Trash",true)

            # remote Command injection fix - use cron or review folders creation
           #  system "chown -R vmail "+maildir+"/"+@domain+"/"+@nick
           #  system "chmod -R 700 "+maildir+"/"+@domain+"/"+@nick

          end      
        end  
    end
      

    #approve registration
    self.approved = true
    self.save

  
    # create invoice if not free (sends on create)
  
   end  
  end


end

