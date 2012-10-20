Spree::Core::Engine.routes.append do
  match "checkout/gateway/payuin/:id/callback" => 'checkout#callback', :as => :gateway_payuin_callback, :method => :post
end
