require 'rails_helper'

RSpec.describe "MarketVendor API", type: :request do
  describe 'POST /api/v0/market_vendors' do
    before(:each) do
      @market = create(:market, name: "Chelsea Market")
      @vendor = create(:vendor, name: "Bread Alone")
    end
    it 'happy path - can create a new market_vendor' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      mv_params = { market_id: @market.id, vendor_id: @vendor.id }

      expect(MarketVendor.count).to eq(0)
      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(mv_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      mv = JSON.parse(response.body, symbolize_names: true)

      expect(mv).to be_a Hash
      expect(mv).to have_key(:message)
      expect(mv[:message]).to eq("Successfully added Bread Alone to Chelsea Market")
      expect(MarketVendor.count).to eq(1)
    end

    it 'sad path - missing required attributes' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      mv_params = { market_id: nil, vendor_id: @vendor.id }

      expect(MarketVendor.count).to eq(0)
      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(mv_params)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      mv_error = JSON.parse(response.body, symbolize_names: true)
      expect(mv_error).to be_a Hash
      expect(mv_error).to have_key(:errors)
      expect(mv_error[:errors]).to be_an Array
      expect(mv_error[:errors][0]).to be_a Hash
      expect(mv_error[:errors][0]).to have_key(:detail)
      expect(mv_error[:errors][0][:detail]).to eq("Validation failed: market or vendor does not exist")
      expect(MarketVendor.count).to eq(0)
    end
    
    it 'sad path - MarketVendor already exists' do
      MarketVendor.create!(market_id: @market.id, vendor_id: @vendor.id)
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      mv_params = { market_id: @market.id, vendor_id: @vendor.id }
      
      expect(MarketVendor.count).to eq(1)
      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(mv_params)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      mv_error = JSON.parse(response.body, symbolize_names: true)
      
      expect(mv_error[:errors][0][:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{@market.id} and vendor_id=#{@vendor.id} already exists")
      expect(MarketVendor.count).to eq(1)
    end
  end
end