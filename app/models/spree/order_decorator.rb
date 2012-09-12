module Spree
  class Order < ActiveRecord::Base
    checkout_flow do
      go_to_state :address
      go_to_state :delivery
      go_to_state :payment, :if => lambda { |order| false}
      go_to_state :confirm
      go_to_state :external_payment
      go_to_state :complete
    end
  end
end
