module Spree
  module Payuin
    class PaymentTransaction < ActiveRecord::Base
      set_table_name 'spree_payuin_payment_transactions'
    
      attr_accessible :checksum, :payment_id, :transaction_id, :status, :response

      attr_accessor :authorization, :avs_result

      def success?
        true
      end

      def self.create_using order
        Spree::Payuin::PaymentTransaction.new.tap do |transaction|
          transaction.checksum = generate_checksum(order)
          transaction.transaction_id = generate_transaction_id(order.number) 
        end
      end

      def self.generate_checksum order
        Digest::SHA512.hexdigest("#{order.payment_method.preferred_merchant_id}|#{generate_transaction_id(order.number)}|#{order.total.to_f}|#{order.number}|#{order.bill_address.firstname}|#{order.user.email}|||||||||||#{order.payment_method.preferred_salt}")
      end

      def self.generate_transaction_id number
        "#{SecureRandom.uuid}-#{number}"
      end
    end
  end
end
