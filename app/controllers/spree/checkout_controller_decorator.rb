Spree::CheckoutController.class_eval do
  include Spree::Payuin::Gateway

  def before_external_payment
    @order.payments.destroy_all
    payment_method = Spree::PaymentMethod.find_by_type "Spree::Payuin::PaymentMethod"
    @order.payments.build(:amount => @order.total, :payment_method_id => payment_method.id)    
    payment = Spree::Payuin::PaymentTransaction.build_using @order, payment_method
    @order.payment.source = payment
    @order.state = "external_payment"
    @order.save!
  end

  def before_complete
    unless @order.payment.source.success?
      flash[:error] = t(:payment_processing_failed)
      redirect_to spree.edit_order_path(@order)
    end
  end
end
