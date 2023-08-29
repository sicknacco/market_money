require 'rails_helper'

RSpec.describe "MarketVendor API", type: :request do
  describe 'POST /api/v0/market_vendors' do
    it 'happy path - can create a new market_vendor' do
      market = create(:market, name: "Chelsea Market")
      vendor = create(:vendor, name: "Bread Alone")

      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      mv_params = { market_id: market.id, vendor_id: vendor.id }

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
  end
end