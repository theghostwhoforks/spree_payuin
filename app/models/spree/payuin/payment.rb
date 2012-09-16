module Spree
  module Payuin
    class Payment < ActiveRecord::Base

      attr_accessor :authorization, :avs_result

      def success?
        true
      end
    end
  end
end
