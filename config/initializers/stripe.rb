Rails.configuration.stripe = {
  :publishable_key => 'pk_test_lXYNhsmGnvqFaAJMKwcqJ5i5',
  :secret_key      => 'sk_test_t5t2r1Au1OBrH3unVVOmkcJA'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]