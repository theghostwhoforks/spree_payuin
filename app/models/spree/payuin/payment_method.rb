module Spree
  module Payuin
    class PaymentMethod < Spree::PaymentMethod
      preference :account_id,  :string
      preference :url,         :string, :default =>  "https://test.payu.in/_payment"
      preference :mode,        :string
      preference :merchant_id, :string
      preference :salt,        :string
      
      attr_accessible :preferred_account_id, :preferred_url, :preferred_mode, :preferred_merchant_id, :preferred_salt

      def payment_profiles_supported?
        true
      end

      def actions
          %w(purchase)
      end

      def can_purchase?(payment)
        true
      end
      
      def purchase(money, source, options)
        source.authorization = 42
        source.avs_result = {'code' => 'success'}
        source
      end

      def payment_source_class
        Spree::Payuin::PaymentTransaction
      end
    end
  end
end
