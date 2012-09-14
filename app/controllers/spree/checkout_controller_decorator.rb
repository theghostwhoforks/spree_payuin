Spree::CheckoutController.class_eval do
  def before_external_payment
    @order.payments.destroy_all
    payment_method = Spree::PaymentMethod.find_by_name "PayuIn"
    @order.payments.create(:amount => @order.total, :payment_method_id => payment_method.id)    
  end
end
