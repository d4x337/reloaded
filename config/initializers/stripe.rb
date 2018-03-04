if Rails.env.development? or Rails.env.test?
    Rails.configuration.stripe = {
        :publishable_key =>  'pk_live_Lu6ibTa04s1Np4M2TkGu98PN',
        :secret_key      => 'sk_live_kX8mJwUBz4gSr418nJRr4bkC'
    }
else
    Rails.configuration.stripe = {
        :publishable_key =>  '<% ENV["STRIPE_PUBLISHABLE_KEY"] %>',
        :secret_key      => '<% ENV["STRIPE_SECRET_KEY"] %>'
    }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]

