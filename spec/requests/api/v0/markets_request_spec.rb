require 'rails_helper'

RSpec.describe "Market API", type: :request do
  describe "GET /api/v0/markets" do
    it "returns all markets" do
      create_list(:market, 10)

      get "/api/v0/markets"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      markets = JSON.parse(response.body, symbolize_names: true)

      markets[:data].each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)
        expect(market).to have_key(:type)
        expect(market[:type]).to eq('market')
        expect(market).to have_key(:attributes)

        expect(market[:attributes]).to be_a(Hash)
        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_a(String)
        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a(String)
        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a(String)
        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a(String)
        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a(String)
        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a(String)
        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a(String)
        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a(String)
      end
    end

    it 'can return an added attribute of vendor_count' do
      market1 = create(:market)
      market2 = create(:market)
      vendors1 = create_list(:vendor, 3)
      mv1 = MarketVendor.create!(market_id: market1.id, vendor_id: vendors1[0].id)
      mv2 = MarketVendor.create!(market_id: market1.id, vendor_id: vendors1[1].id)
      mv3 = MarketVendor.create!(market_id: market2.id, vendor_id: vendors1[2].id)

      get "/api/v0/markets"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      
      expect(markets[:data][0][:attributes]).to have_key(:vendor_count)
      expect(markets[:data][0][:attributes][:vendor_count]).to be_an Integer
      expect(markets[:data][0][:attributes][:vendor_count]).to eq(2)
      expect(markets[:data][1][:attributes]).to have_key(:vendor_count)
      expect(markets[:data][1][:attributes][:vendor_count]).to be_an Integer
      expect(markets[:data][1][:attributes][:vendor_count]).to eq(1)
    end
  end
end