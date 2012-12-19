module Spree
  module Payuin
    module Gateway
      def self.included(klass)
        klass.skip_before_filter :verify_authenticity_token,:ensure_valid_state, :only=> [:callback]
      end

      def callback
        @order = Spree::Order.find_by_number params[:productinfo]
        payment = @order.payment
        record_transaction payment
        payment_transaction = payment.source
        payment_transaction.update_attributes!(:status => params[:status])
        verify_checksum params 
        callback_method = "#{params[:status]}_callback".gsub(/\s/,'_')
        self.send(callback_method)
      end


      def verify_checksum params
        valid = @order.payment.source.checksum_valid?(params)
        unless valid
          @order.payment.source.update_attributes(:status => 'failure')
          flash[:error] = t(:payment_processing_failed)
          redirect_to spree.checkout_state_path(@order)
        end
      end

      alias_method :in_progress, :success_callback

      def success_callback
        if @order.next
          state_callback(:after)
        else
          flash[:error] = t(:payment_processing_failed)
          redirect_to spree.checkout_state_path(@order) and return
        end

        if @order.state == "complete" || @order.completed?
          flash[:notice] = t(:order_processed_successfully)
          redirect_to spree.order_path(@order, { :checkout_complete => true }) and return
        else
          redirect_to spree.checkout_state_path(@order) and return
        end
      end

      def failure_callback
        @order.state = "cart"
        @order.save!
        flash[:error] = t(:payment_processing_failed)
        redirect_to spree.edit_order_path(@order)        
      end

      def cancel_callback
        @order.state = "cart"
        @order.save!
        flash[:notice] = t(:payment_processing_cancelled)
        redirect_to spree.edit_order_path(@order)
      end

      def record_transaction payment
        payu_response = params.slice("mihpayid", "mode","unmappedstatus","txnid", "hash","PG_TYPE","bank_ref_num","bankcode","error","cardhash")
        log_entry = payment.log_entries.build
        log_entry.details = payu_response.to_json
        log_entry.save!
      end
    end
  end
end
