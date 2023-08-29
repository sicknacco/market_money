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

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: 201
    else
      render json: { "errors": [{ "detail": "Validation failed: Contact name can't be blank, Contact phone can't be blank" }] }, status: 400
    end
  end

  private
  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end