class MailAccountsController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:change]
  layout "dashboard"
  
  def index
     @mail_accounts = MailAccount.all
     respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @mail_accounts }
    end
  end

  def show
    @mail_account = MailAccount.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @mail_accounts }
    end
  end

  def new
    @mail_account = MailAccount.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mail_accounts }
    end
  end

  def subscribe
    if params['prod_id'].present?
      @prod_id = params['prod_id']
      @prod = Product.find(@prod_id)
    end    
  
    @mail_account = MailAccount.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @mail_accounts }
    end
  end


  def edit
    @mail_account = MailAccount.find(params[:id])
  end

  def createOLDKO
    @choosen_account = User.find_by_nickname(params[:nicks])
    @choosen_domain  = Domain.find_by_domain(params[:domain])
    @choosen_quota   = params[:quota]
 
    @mail_account = MailAccount.new(:user_id=>@choosen_account.id,:login=>params[:nicks]+"@"+@choosen_domain.domain,:name=>params[:name],:password=>params[:password],:tip=>params[:password],:quota=>@choosen_quota,:maildir=>@choosen_domain.vmaildir,:home=>@choosen_domain.homedir)
    
    @maildir = Maildir.new(@choosen_domain.vmaildir+"/"+@choosen_domain.homedir+"/"+params[:nicks],true)   #false skip directory creation
   # system('/var/www/blog/lib/tasks/fix-maildir-permissions.sh' )
    
      respond_to do |format|
        if @mail_account.save
          format.html  { redirect_to(mail_accounts_url,:notice => 'Uberbox successfully created.') }
          format.json  { render :json => @mail_account, :status => :created, :location => @mail_account }
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @mail_account.errors, :status => :unprocessable_entity }
        end
      end
  end
  
  def change
      @account_id = params['account_id']
      MailAccount.where(:user_id=>current_user.id.to_s).update_all(:defaultbox=>false)
      @mail_account = MailAccount.find(@account_id)
      @mail_account.defaultbox = true;
      @mail_account.save
 
      respond_to do |format|
          format.html  { redirect_to(request.referer,:notice => 'Account changed to '+@mail_account.login) }
          format.json  { render :json => {:fromname=>@mail_account.name,:fromaddress=>@mail_account.login}, :status => :created, :location => @mail_account }
      end
      
      #render :json => {:fromname=>@mail_account.name,:fromaddress=>@mail_account.login}
  end
  
  def configure
    
  end
  
  def subscribe
     @GB1 = Product.find(2)
     @GB3 = Product.find(3)
     @GB5 = Product.find(4)
  end


  def create
    if params['subscribed'] == "Create Mailbox"
          if params['prod_id'].present?
            prod= params['prod_id']
          end
            
          @mail_account = MailAccount.new(params[:mail_account])
          @mail_account.user_id = current_user.id
          @mail_account.maildir = params['domain']+"/"+@mail_account.login
          @mail_account.login   = @mail_account.login+"@"+params['domain']
          @mail_account.home    = "/var/vmail"
          @mail_account.gid     = 2000
          @mail_account.uid     = 2000
          @mail_account.tip     = Digest::SHA256.hexdigest(params[:mail_account][:password])
   
            if @mail_account.save
               @maildir = Maildir.new("/var/vmail/"+@mail_account.maildir,true)
               @sentdir = Maildir.new("/var/vmail/"+@mail_account.maildir+"/.Sent",true)
               @draftdir= Maildir.new("/var/vmail/"+@mail_account.maildir+"/.Drafts",true)
               @trashdir= Maildir.new("/var/vmail/"+@mail_account.maildir+"/.Trash",true)
               @trashdir= Maildir.new("/var/vmail/"+@mail_account.maildir+"/.Spam",true)
               respond_to do |format|
                format.html  { render :action => "configure" }
                format.json  { render :json => @mail_account, :status => :created, :location => @mail_account }
               end 
            else
              respond_to do |format|
               format.json  { render :json => @mail_account.errors, :status => :unprocessable_entity }
               format.html  { redirect_to(:action => "subscribe",:prod_id=>prod) }
              end
            end
    else
        @tip = Digest::SHA256.hexdigest(params[:mail_account][:password])
        @mail_account = MailAccount.new(params[:mail_account])
          respond_to do |format|
          if @mail_account.save
             @maildir = Maildir.new(params[:mail_account][:home]+"/"+params[:mail_account][:maildir],true)   #false skip directory creation
             @sentdir = Maildir.new(params[:mail_account][:home]+"/"+params[:mail_account][:maildir]+"/.Sent",true)
             @draftdir= Maildir.new(params[:mail_account][:home]+"/"+params[:mail_account][:maildir]+"/.Drafts",true)
             @trashdir= Maildir.new(params[:mail_account][:home]+"/"+params[:mail_account][:maildir]+"/.Trash",true)
             @trashdir= Maildir.new(params[:mail_account][:home]+"/"+params[:mail_account][:maildir]+"/.Spam",true)
            format.html  { redirect_to(request.referer,:notice => 'Uberbox successfully created.') }
            format.json  { render :json => @mail_account, :status => :created, :location => @mail_account }
          else
            format.html  { redirect_to(request.referer) }
            format.json  { render :json => @mail_account.errors, :status => :unprocessable_entity }
          end
        end
    end
  end

  def update
    @mail_account = MailAccount.find(params[:id])
    respond_to do |format|
      if @mail_account.update_attributes(params[:mail_account])
        format.html  { redirect_to(request.referer, :notice => 'Mail ACcount Updated.') }
        format.json  { head :no_content }
      else
        format.html  { redirect_to(request.referer, :alert => 'Error') }
        format.json  { render :json => @mail_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mail_account = MailAccount.find(params[:id])
    @mail_account.destroy
    respond_to do |format|
       format.html { redirect_to mail_accounts_url }
       format.json { head :no_content }
    end
  end
  
    private
  def custom_layout
       if current_user.role? :admin  
        "dashboard"    
       else current_user.role? :user
        "welcome"
       end 
   end
   
end



