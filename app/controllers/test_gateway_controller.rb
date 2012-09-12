class TestGatewayController < Spree::BaseController

  def payment
    redirect_to gateway_payuin_callback_path(params)
  end

end
