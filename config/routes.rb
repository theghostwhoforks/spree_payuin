Spree::Core::Engine.routes.append do
  match "/gateway/payuin/:id/callback" => 'payuin/gateway#callback', :as => :gateway_payuin_callback
end
