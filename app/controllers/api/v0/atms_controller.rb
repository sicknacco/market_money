class Api::V0::AtmsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    if market.present?
      atms = AtmFacade.get_atms(market)
      render json: AtmSerializer.new(atms)
    end
  end
end