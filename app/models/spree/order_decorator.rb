#Copyright 2013 ThoughtWorks, Inc. Licensed under the Apache License, Version 2.0.
Spree::Order.class_eval do
  checkout_flow do
    go_to_state :address
    go_to_state :delivery
    # Turn off the default payment transition
    go_to_state :payment, :if => lambda { |order| false}
    go_to_state :confirm
    go_to_state :external_payment
    go_to_state :complete

    # TODO - Write tests for these before plugging them in
    # remove_transition :from => :delivery, :to => :confirm
    # remove_transition :from => :confirm, :to => :confirm
  end
end
