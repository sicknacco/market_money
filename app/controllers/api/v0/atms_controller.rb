class Api::V0::AtmsController < ApplicationController
  def index
    market = Market.find_by(id: params[:market_id])
    if market.present?
      atms = AtmFacade.get_atms(market)
      render json: AtmSerializer.new(atms)
    else
      render json: { "errors": [{ "detail": "Couldn't find Market with 'id'=#{params[:market_id]}" }] }, status: 404 
    end
  end
end