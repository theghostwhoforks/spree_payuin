module Spree
  module Payuin
    class PaymentTransaction < ActiveRecord::Base
      self.table_name = 'spree_payuin_payment_transactions'
      belongs_to :payment_method, :class_name => 'Spree::Payuin::PaymentMethod'
    
      attr_accessible :checksum, :payment_id, :transaction_id, :status, :response, :payment_method_id

      attr_accessor :authorization, :avs_result

      def success?
        puts "status == #{self.status}"
        true
      end

      def self.create_using order
        Spree::Payuin::PaymentTransaction.new.tap do |transaction|
          puts transaction.inspect
          transaction.checksum = generate_checksum(order)
          transaction.transaction_id = generate_transaction_id(order.number) 
        end
      end

      def self.generate_checksum order
        options = {}
        options[:key] = order.payment_method.preferred_merchant_id
        options[:txnid] = generate_transaction_id order.number
        options[:amount] = order.total.to_f
        options[:productinfo] = order.number
        options[:firstname] = order.bill_address.firstname
        options[:email] = order.user.email
        options[:salt] = order.payment_method.preferred_salt
        compute_checksum options 
      end

      #for now as payu is unable to process
      def self.generate_transaction_id number
        number
      end

      def checksum_valid? checksum_data
        self.checksum == checksum_data 
      end

      def self.compute_checksum data
        Digest::SHA512.hexdigest(checksum_template(data))
      end

      def self.checksum_template options
        "#{options[:key]}|#{options[:txnid]}|#{options[:amount]}|#{options[:productinfo]}|#{options[:firstname]}|#{options[:email]}|||||||||||#{options[:salt]}"   
      end

    end
  end
end
