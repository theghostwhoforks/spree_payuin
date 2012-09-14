module Spree
  module Payuin
    class Payment < ActiveRecord::Base
      has_many :payments, :as => :source
    end
  end
end
