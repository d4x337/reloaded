class Income < ActiveRecord::Base
 
  INCOME_TYPES = %w[UNA_TANTUM MONTHLY ANNUAL]
 
  belongs_to :user
  
  has_one :order, :foreign_key=>:order_id
  
  validates :user_id,:income_id, :presence => true
  
  validates :income_type, :inclusion => { :in => INCOME_TYPES }

# after_create :congrats_new_income
  
 # after_destroy :send_removed_from_ring_message
  
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