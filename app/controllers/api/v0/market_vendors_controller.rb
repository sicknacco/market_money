class Api::V0::MarketVendorsController < ApplicationController
  def create
    market = Market.find_by(id: params[:market_id])
    vendor = Vendor.find_by(id: params[:vendor_id])
    mv = MarketVendor.new(market: market, vendor: vendor)
    if mv.save
      render json: { "message": "Successfully added #{vendor.name} to #{market.name}" }, status: 201
    else market.nil? || vendor.nil?
      render json: { "errors": [{ "detail": "Validation failed: market or vendor does not exist" }] }, status: 404
    end
  end
end