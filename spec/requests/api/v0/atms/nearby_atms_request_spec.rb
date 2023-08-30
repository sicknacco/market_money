require 'rails_helper'

RSpec.describe 'Atms API', type: :request do
  describe 'GET /api/v0/markets/:id/nearest_atms' do
    it 'returns nearest atms', :vcr do
      market = create(:market)

      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }

      get "/api/v0/markets/#{market.id}/nearest_atms", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      atms = JSON.parse(response.body, symbolize_names: true)

      expect(atms[:data]).to be_an(Array)
      atms[:data].each do |atm|
        expect(atm).to have_key(:id)
        expect(atm[:id]).to eq(nil)
        expect(atm).to have_key(:type)
        expect(atm[:type]).to eq('atm')
        expect(atm).to have_key(:attributes)
        expect(atm[:attributes]).to be_a(Hash)

        expect(atm[:attributes]).to have_key(:name)
        expect(atm[:attributes][:name]).to eq('ATM')
        expect(atm[:attributes]).to have_key(:address)
        expect(atm[:attributes][:address]).to be_a(String)
        expect(atm[:attributes]).to have_key(:lat)
        expect(atm[:attributes][:lat]).to be_a(Float)
        expect(atm[:attributes]).to have_key(:lon)
        expect(atm[:attributes][:lon]).to be_a(Float)
        expect(atm[:attributes]).to have_key(:distance)
        expect(atm[:attributes][:distance]).to be_a(Float)
      end
    end

    it 'returns an error if market does not exist', :vcr do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
    
      get "/api/v0/markets/000000/nearest_atms", headers: headers
    
      atm_error = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    
      expect(atm_error[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=000000")
    end
  end
end