Spree::Core::Engine.routes.append do
  match "/gateway/payuin/:id/callback" => 'payuin/gateway#callback', :as => :gateway_payuin_callback
  match "/test_gateway/_payment/:id", :to => redirect {|params| "/gateway/payuin/#{params[:id]}/callback"}, :as => :test_gateway
end
