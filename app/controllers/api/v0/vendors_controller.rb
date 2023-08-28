class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    if market.present?
      render json: VendorSerializer.new(market.vendors)
    else
      render json: { "errors": [{ "detail": "Couldn't find Market with 'id'=#{params[:id]}" }] }, status: 404
    end
  end
end