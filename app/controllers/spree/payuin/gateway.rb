module Spree
  module Payuin
    module Gateway
      def self.included(klass)
        klass.skip_before_filter :verify_authenticity_token,:ensure_valid_state, :only=> [:callback]
      end

      def callback
        payment_transaction = @order.payment.source
        payment_transaction.update_attributes!(:status => params[:status], :response => params.to_json)
        verify_checksum params 
        self.send("#{params[:status]}_callback")
      end


      def verify_checksum params
        valid = @order.payment.source.checksum_valid?(params)
        unless valid
          flash[:error] = t(:payment_processing_failed)
          redirect_to spree.checkout_state_path(@order)
        end
      end

      def success_callback
        logger.info "order details commence"
        logger.info @order.inspect
        logger.info @order.state
        logger.info "order details done"
        if @order.next
          state_callback(:after)
        else
          flash[:error] = t(:payment_processing_failed)
          redirect_to spree.checkout_state_path(@order)
        end

        if @order.state == "complete" || @order.completed?
          flash[:notice] = t(:order_processed_successfully)
          redirect_to spree.order_path(@order, { :checkout_complete => true })
        else
          redirect_to spree.checkout_state_path(@order)
        end
      end

      def failure_callback
        flash[:error] = t(:payment_processing_failed)
        redirect_to spree.edit_order_path(@order)        
      end

      def cancel_callback
        flash[:notice] = t(:payment_processing_cancelled)
        redirect_to spree.edit_order_path(@order)
      end
    end
  end
end
