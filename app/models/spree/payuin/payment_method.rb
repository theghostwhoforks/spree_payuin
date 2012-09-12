class Spree::Payuin::PaymentMethod < Spree::PaymentMethod
  preference :account_id,  :string
  preference :url,         :string, :default =>  "https://test.payu.in/_payment"
  preference :mode,        :string
  preference :merchant_id, :string
	preference :salt,        :string
  

  def payment_profiles_supported?
    true
  end

  def provider_class
    self.class
  end

  def method_type
    'payuin'
  end

# TODO: Move to a separate class
  def actions
      %w(capture)
  end
  
  def capture(authorization, credit_card, gateway_options)
    ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '67890')
  end
end
