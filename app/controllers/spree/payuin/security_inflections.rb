module Spree
  module Payuin
    module SecurityInflections
      def self.included klass
        klass.before_filter :prevent_add_to_cart, :only => [:populate]
        klass.before_filter :prevent_order_mutation_when_in_payment_mode, :only => [:update]
        klass.after_filter :dissociate_user, :only => [:empty]
      end

      def prevent_add_to_cart
        order = current_order
        return true unless order
        if order.state == 'external_payment'
          flash[:notice] = t(:duplicate_order)
          redirect_to spree.cart_path 
        end
      end

      #TODO - remove unsetting user on orde. we won't be able to track cart abandonment because of this
      def dissociate_user
        if user = try_spree_current_user
          if order = current_order and order.state == 'external_payment'
            @current_order = nil
            session[:order_id] = nil
            user.spree_orders.delete order
            order.user_id = nil
            order.state = 'cart'
            order.save!
          end
        end
      end

      def prevent_order_mutation_when_in_payment_mode
        if request.put?
          order = current_order
          if order.state == 'external_payment'
            flash[:notice] = t(:duplicate_order)
            redirect_to spree.cart_path 
          end
        end
      end
    end
  end
end
