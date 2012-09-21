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
        Digest::SHA512.hexdigest(checksum_template(options))
      end

      #for now as payu is unable to process
      def self.generate_transaction_id number
        number
      end

      def checksum_valid? checksum_data
        salt = payment_method.preferred_salt
        options = checksum_data.slice(:status,:email,:firstname,:productinfo,:amount,:txnid,:key).merge(:salt => salt)
        checksum_data[:hash] == Digest::SHA512.hexdigest(return_checksum_template(options))
      end

      def self.checksum_template options
        "#{options[:key]}|#{options[:txnid]}|#{options[:amount]}|#{options[:productinfo]}|#{options[:firstname]}|#{options[:email]}|||||||||||#{options[:salt]}"   
      end

      def self.return_checksum_template options
        "#{options[:salt]}|#{options[:status]}|||||||||||#{options[:email]}|#{options[:firstname]}|#{options[:productinfo]}|#{options[:amount]}|#{options[:txnid]}|#{options[:key]}"
      end
    end
  end
end
