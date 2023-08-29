class Api::V0::MarketVendorsController < ApplicationController
  def create
    market = Market.find(params[:market_id])
    vendor = Vendor.find(params[:vendor_id])
    mv = MarketVendor.new(market: market, vendor: vendor)
    if mv.save
      render json: { "message": "Successfully added #{vendor.name} to #{market.name}" }, status: 201
    end
  end
end