class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    market = Market.find_by(id: params[:id])
    if market.present?
      render json: MarketSerializer.new(market), status: 200
    else
      render json: { "errors": [{ "detail": "Couldn't find Market with 'id'=#{params[:id]}" }] }, status: 404
    end
  end
end