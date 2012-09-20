Spree::Core::Engine.routes.append do
  match "checkout/gateway/payuin/:id/callback" => 'checkout#callback', :as => :gateway_payuin_callback
  match "/test_gateway/_payment/:id", :to => redirect {|params| "checkout/gateway/payuin/#{params[:id]}/callback"}, :as => :test_gateway
end
