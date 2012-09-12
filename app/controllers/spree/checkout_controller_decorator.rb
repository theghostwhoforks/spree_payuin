Spree::CheckoutController.class_eval do
  def before_external_payment
    payment_method = Spree::PaymentMethod.find_by_name "PayuIn"
    @order.payments_attributes = [{:payment_method_id => payment_method.id}]
    @order.save
  end
end
