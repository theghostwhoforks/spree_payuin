require 'spec_helper'

describe Spree::CheckoutController do

  after :each do
    request.session[:order_id] = nil
  end

  it "should populate the payment method before external payment state transition" do
    setup_payment_method
    setup_order

    request.session[:order_id] = @order.id

    controller.before_external_payment

    @order.reload
    @order.payment.source_type.should == "Spree::Payuin::PaymentTransaction"
    @order.state.should == "external_payment"
  end

  private

  def setup_payment_method
    payment = Spree::Payuin::PaymentMethod.find_or_create_by_name_and_environment('PayuIn', 'test') do |p|
      p.preferred_merchant_id = "xxxxxxx"
    end
  end

  def setup_order
    address = FactoryGirl.build :address
    payment = FactoryGirl.build :payment
    @order = payment.order
    @order.bill_address = @order.ship_address = address
    @order.save!
  end
end
