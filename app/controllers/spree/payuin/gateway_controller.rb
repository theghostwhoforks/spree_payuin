module Spree
  module Payuin
    class GatewayController < Spree::BaseController
      def callback
          order = Spree::Order.find params[:id]
          redirect_to spree.order_path(order, { :checkout_complete => true })        
      end
    end
  end
end

