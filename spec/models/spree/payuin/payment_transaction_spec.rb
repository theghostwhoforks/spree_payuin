require 'spec_helper'

describe Spree::Payuin::PaymentTransaction do
  before :each do
    @salt = "roadrunner"
    @template = lambda do |options|
      "#{options[:salt]}|#{options[:status]}|||||||||||#{options[:email]}|#{options[:firstname]}|#{options[:productinfo]}|#{options[:amount]}|#{options[:txnid]}|#{options[:key]}"
    end
  end

  it "should validate return checksum from payu" do
    response = HashWithIndifferentAccess.new
    response[:status] = "success"
    response[:email] = "coyote@acme.com"
    response[:firstname] = "coyote"
    response[:productinfo] = "acme roadrunner costume"
    response[:amount] = "42"
    response[:txnid] = "42" * 7
    response[:key] = "ACME42"
    response[:hash] = Digest::SHA512.hexdigest @template.call(response.merge(:salt => @salt))

    payment_method = double('payment_method') 
    payment_method.stub(:preferred_salt) {@salt}
    transaction = Spree::Payuin::PaymentTransaction.new
    transaction.should_receive(:payment_method).and_return(payment_method)

    transaction.checksum_valid?(response).should be_true
  end
end
