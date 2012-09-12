class TestGatewayController < Spree::BaseController

  def payment
    redirect_to params[:redirect_url], params => params
  end

end
