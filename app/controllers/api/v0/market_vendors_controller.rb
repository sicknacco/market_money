class Api::V0::MarketVendorsController < ApplicationController
  def create
    market = Market.find_by(id: params[:market_id])
    vendor = Vendor.find_by(id: params[:vendor_id])
    mv = MarketVendor.new(market: market, vendor: vendor)
    if mv.save
      render json: { "message": "Successfully added #{vendor.name} to #{market.name}" }, status: 201
    elsif market.nil? || vendor.nil?
      render json: { "errors": [{ "detail": "Validation failed: market or vendor does not exist" }] }, status: 404
    else
      render json: { "errors": [{ "detail": "Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists" }] }, status: 422
    end
  end

  def destroy
    mv = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
    if mv.present?
      mv.destroy
      render json: {}, status: 204
    end
    # require 'pry'; binding.pry
  end
end