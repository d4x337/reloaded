class Order < ActiveRecord::Base
  
  belongs_to :cart

  attr_accessible :last_name,:first_name,:express_token,:gender,:country,:role,:birthday,:billing_address,:billing_email,:first_pass,:transaction_id,:status,
  :currency,:amount,:zip,:town,:city,:address,:shipping_city,:shipping_country,:shipping_first_name,:shipping_last_name,:shipping_address,:shipping_zip,:shipping_town,:telephone,:internal_notes,:customer_notes
  
  validates :first_name,:last_name,:presence => true
  
  validates :first_name ,:presence => true, :length => { :in => 2..50 },:format => { :with => /\A[a-zA-Z\s]+\z/,   :message => "only letters and space allowed " }
  validates :last_name  ,:presence => true, :length => { :in => 2..50 },:format => { :with => /\A[a-zA-Z\s]+\z/,   :message => "only letters and space allowed" }
    
  has_many :transactions, :class_name => "OrderTransaction"
  has_many :rows, :class_name => "OrderRow"
  
  attr_accessor :card_number, :card_verification
  #before_create :validate_card
  
  def purchase
    response = process_purchase
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    
    self.cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
 
  def approve_registration(user_id)
    @user = User.find(user_id)
    @user.approved = true
    @user.save!  
  end
  
  def send_welcome_message
    begin  
      UserMailer.welcome_email(self).deliver
     rescue Net::SMTPFatalError => ex
      if not ex.to_s.blank?
        raise ex
      end
    end  
  end

  def create_subscription
    @subscription = Subscription.create(:user_id=>0,:order_id=>self.id,:cart_id=>self.cart_id,:starting_from=>DateTime.now,:expire_on=>DateTime.now+1.year,:auto_renewal=>true,:last_payment=>DateTime.now)
  end
    
  
  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
    end
  end

  
  def price_in_cents
    (self.total*100).round
  end

  private
  
  def process_purchase
    #if express_token.blank?
    #  STANDARD_GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
    #else
      EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
    #end
  end
  
  def standard_purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
  
  def express_purchase_options
    {
      :ip => ip_address,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end
  
  def validate_card
    if express_token.blank? && !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
end


