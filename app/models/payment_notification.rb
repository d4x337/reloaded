class PaymentNotification < ActiveRecord::Base

    belongs_to :cart
    serialize :params
    after_create :mark_cart_as_purchased
    
    private
    
    def mark_cart_as_purchasedOLD
      if status == "Completed"
        cart.update_attribute(:purchased_at,Time.now)
            
      end
    end
    
    #test secret...replace for prod
    def mark_cart_as_purchased
      if status == "Completed" && params[:secret] == "1395049619"
        cart.update_attribute(:purchased_at, Time.now)
      elsif status == "Completed"
        cart.update_attribute(:purchased_at, Time.now)
      end
    end
   
    def do_backoffice

      @order = Order.where(:cart_id=>self.cart_id).first
    
      @user = User.create(
        :firstname=>@order.first_name,
        :lastname=>@order.first_name,
        :nickname=>@order.first_name,
        :email=>@order.email,
        :gender=>@order.first_name,
        :birthdate=>@order.first_name,
      )  
      
      #if there is a request of partnership, save the roles offered in the order
      if not cart.request_token.blank?
          @request = Request.find_by_token(cart.request_token)
          #verify token integridy, validate it
          @role = @request.relation
      end
    
      #if the customer has been invited, grant income to the partner"
      if not cart.invitation_token.blank?
         @user.invitation.update_attributes(:accepted=>true,:read_at=>Time.now)
         @seller = User.find(@user.invitation.user_id)
      
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
         Income.create(:user_id=>@user.invitation.user_id,:income=>@income5,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
   
         @prj_parent_pr = prj_parent_pr(@seller.id)
         if not @prj_parent_pr.blank?
           #Grant income to PR 5%
           Income.create(:user_id=>@prj_parent_pr.user_id,:income=>@income5,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
   
           #parent PR has a parent CPR?
           @cpr_parent_pr = prj_parent_pr(@prj_parent_pr.user_id)
           if not @cpr_parent_pr.blank?
             #Grant income to CPR 10%
             Income.create(:user_id=>@cpr_parent_pr.user_id,:income=>@income10,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
             #Grant income to Gestione 10%
             Income.create(:user_id=>0,:income=>@income10,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
         else  
           @prj_parent_cpr = prj_parent_cpr(@seller.id)
           
           #check this for bugs (double parent jump with no pr in the middle)
           if not @prj_parent_cpr.blank?
             #Grant income to CPR 15%
             Income.create(:user_id=>@prj_parent_cpr.user_id,:income=>@income10+@income5,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
             #Grant income to Gestione 15% 
             Income.create(:user_id=>0,:income=>@income10+@income5,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
         end
         
         elsif @seller.role? :pr
           #Grant income to PR 10%
           Income.create(:user_id=>@user.invitation.user_id,:income=>@income10,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           @cpr_parent_pr = cpr_parent_pr(@seller.id)
   
           if not @cpr_parent_pr.blank?
            #Grant income to CPR 10%
            Income.create(:user_id=>@cpr_parent_pr.user_id,:income=>@income10,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           else  
            #Grant income to Gestione 10%
            Income.create(:user_id=>0,:income=>@income10,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
           end
  
       elsif @seller.role? :cpr
         Income.create(:user_id=>@user.invitation.user_id,:income=>@income20,:income_id=>@user.id,:order_id=>@order.id,:income_id=>@user.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
       end
    else
       #Grant income to Gestione
       Income.create(:user_id=>0,:income_id=>@user.id,:income=>@income20,:order_id=>@order.id,:expiration=>DateTime.now+1.year,:income_type=>"ANNUAL",:status=>"ACTIVE",:auto_renew=>false)
    end
 
    #create invoice and payment for the next month, if already exists add new line and update total.

    if @role.present?
        Staff.create(:user_id=>@request.user_id,:pr_id=>@user.id,:relation=>@role,:begin_of_relation=>DateTime.now,:end_of_relation=>DateTime.now)
    end
    
    if @role == "PRJ"
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'1000000000S')
        @user.roles_mask = 16
    elsif @role == "PR"
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'3000000000S')
        @user.roles_mask = 8
    elsif @role == "CPR"
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'20000000000S')
        @user.roles_mask = 4
    end  

    #create mailboxes physically
    maildir = "/var/vmail"
    if @order.prod_id = 2
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'1000000000S')
    elsif @order.pro_id = 3
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'3000000000S')
    elsif @order.pro_id = 4
        MailAccount.create(:user_id=>@user.id,:login=>@order.nick+"@"+@order.domain,:defaultbox=>true,:name=>@order.first_name+" "+@order.last_name,:password=>@user.password,:home=>maildir,:maildir=>@order.domain+"/"+@order.nick+"/",:quota=>'20000000000S')
    end  
      
    @maildir    = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/",true)
    @sentdir    = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/.Sent",true)
    @draftdir   = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/.Drafts",true)
    @spamdir    = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/.Spam",true)
    @archivedir = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/.Archive",true)
    @trashdir   = Maildir.new(maildir+"/"+@order.domain+"/"+@order.nick+"/.Trash",true)

    #approve registration
    @user.approved = true
    @user.save

    #create invoice
    
    #send invoice to billing email
    
    #pay incomes

  end  
    
end