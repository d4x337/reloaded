class Charges < ActiveRecord::Base
    attr_accessible :amount, :coupon_id, :stripe_id
    belongs_to :coupon
    validates_presence_of :amount, :stripe_id
end
