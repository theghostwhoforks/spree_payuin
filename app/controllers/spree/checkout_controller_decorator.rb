Spree::CheckoutController.class_eval do
  def before_external_payment
    @order.payments.destroy_all
    payment_method = Spree::PaymentMethod.find_by_name "PayuIn"
    payment = Spree::Payuin::Payment.new
    @order.payments.build(:amount => @order.total, :payment_method_id => payment_method.id)    
    @order.payment.source = payment
    @order.save!
  end
end
