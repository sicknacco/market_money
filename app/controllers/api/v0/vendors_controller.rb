class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find_by(id: params[:market_id])
    if market.present?
      render json: VendorSerializer.new(market.vendors), status: 200
    else
      render json: { "errors": [{ "detail": "Couldn't find Market with 'id'=#{params[:market_id]}" }] }, status: 404
    end
  end

  def show
    vendor = Vendor.find_by(id: params[:id])
    if vendor.present?
      render json: VendorSerializer.new(vendor), status: 200
    else
      render json: { "errors": [{ "detail": "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: 404
    end
  end
end