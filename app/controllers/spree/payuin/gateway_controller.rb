module Spree
  module Payuin
    class GatewayController < Spree::BaseController
      def callback
        payment_method = Spree::PaymentMethod.find_by_name "PayuIn"
        order = Spree::Order.find params[:id]
        puts order.state
        if order.next
          puts order.state
          flash[:notice] = I18n.t(:payment_success)
          redirect_to spree.order_path(order, { :checkout_complete => true })
          # respond_with(order, :location => order_path(@order, :checkout_complete => true))          
        end
        # redirect_to spree.order_path(order, { :checkout_complete => true })
      end
    end
  end
end
