class Income < ActiveRecord::Base
 
  INCOME_TYPES = %w[UNA_TANTUM MONTHLY ANNUAL]
 
  belongs_to :user
  has_one :order, :foreign_key=>:order_id
  validates :user_id,:income_id, :presence => true
  validates :income_type, :inclusion => { :in => INCOME_TYPES }
  attr_accessible :user_id,:income_id,:order_id,:status,:una_tantum, :income,:income_type,:expiration,:auto_renew,:deleted

  private
  def congrats_new_income
    UserMailer.added_to_ring(self.id).deliver
  end
  
  def income_is_expired
    UserMailer.removed_from_ring(self.id).deliver
  end
  
  def distribute_incomes
    # do in transaction...and also for do_backoffice
    
    
  end
  
end