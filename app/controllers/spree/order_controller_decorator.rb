unless ENV['PAYMENT_METHOD'] == 'NEFT'
  Spree::OrdersController.class_eval do
    include Spree::Payuin::SecurityInflections
  end
end
