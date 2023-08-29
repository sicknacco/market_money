require 'rails_helper'

RSpec.describe "Vendor API", type: :request do
  describe 'can return all vendors for a single market' do
    it 'happy path' do
      market = create(:market)
      vendors = create_list(:vendor, 3)
      MarketVendor.create!(market_id: market.id, vendor_id: vendors[0].id)
      MarketVendor.create!(market_id: market.id, vendor_id: vendors[1].id)
      MarketVendor.create!(market_id: market.id, vendor_id: vendors[2].id)

      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      get "/api/v0/markets/#{market.id}/vendors", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)    
      
      vendors_data = JSON.parse(response.body, symbolize_names: true)

      expect(vendors_data[:data].count).to eq(3)
      
      vendors_data[:data].each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_a(String)
        expect(vendor).to have_key(:type)
        expect(vendor[:type]).to eq('vendor')
        expect(vendor).to have_key(:attributes)

        expect(vendor[:attributes]).to be_a Hash
        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
      end
    end

    it 'sad path: market does not exist' do
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      get '/api/v0/markets/0/vendors', headers: headers

      market = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect{Market.find(0)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(market[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=0")
    end
  end
end