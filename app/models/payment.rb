class Payment < ActiveRecord::Base
  # Validation code used to validate returning notifications from iDeal
  #
  attr_accessible :user_id,:income_id,:order_id,:status,:una_tantum,:income,:income_type, :expiration,:auto_renew,:deleted

  def ideal_entrance_code
    Digest::SHA1.hexdigest("#{id}-#{created_at}-#{access_token}")
  end

  def ideal_attributes
    {
        # The customer has 30 minutes to complete the iDeal transaction (ISO 8601)
        :expiration_period => "PT30M",
        :issuer_id         => issuer_id,
        :return_url        => return_url,
        :order_id          => id.to_s,
        :description       => description,
        :entrance_code     => ideal_entrance_code
    }
  end
end
