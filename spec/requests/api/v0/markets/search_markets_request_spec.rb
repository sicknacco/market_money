require 'rails_helper'

RSpec.describe 'Search Markets', type: :request do
  before(:each) do
    @market1 = create(:market, name:'Cool Place', city: 'Grand Junction', state: 'Colorado')
    market2 = create(:market, name:'Okay Place', city: 'Grand Junction', state: 'Colorado')
    market3 = create(:market, name:'Lame Place', city: 'San Diegoo', state: 'California')
  end
  describe 'happy path - GET /api/v0/markets/search' do
    it 'can search for markets by state, city, and name' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        state: 'Colorado',
        city: 'Grand Junction',
        name: 'Cool Place'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data].count).to eq(1)
      expect(markets[:data]).to be_an Array

      markets[:data].each do |market|
        expect(market[:id]).to eq(@market1.id.to_s)
        expect(market[:type]).to eq('market')
        expect(market[:attributes]).to be_a Hash

        expect(market[:attributes][:name]).to eq(@market1.name)
        expect(market[:attributes][:street]).to eq(@market1.street)
        expect(market[:attributes][:city]).to eq(@market1.city)
        expect(market[:attributes][:county]).to eq(@market1.county)
        expect(market[:attributes][:state]).to eq(@market1.state)
        expect(market[:attributes][:zip]).to eq(@market1.zip)
        expect(market[:attributes][:lat]).to eq(@market1.lat)
        expect(market[:attributes][:lon]).to eq(@market1.lon)
        expect(market[:attributes][:vendor_count]).to eq(@market1.vendor_count)
      end
    end

    it 'can search for markets by state and city' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        state: 'Colorado',
        city: 'Grand Junction'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      expect(markets[:data]).to be_an Array
      expect(markets[:data].count).to eq(2)
    end

    it 'can search for markets by state and name' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        state: 'Colorado',
        name: 'Cool Place'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      expect(markets[:data]).to be_an Array
      expect(markets[:data].count).to eq(1)
    end

    it 'can search for markets by state' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        state: 'Colorado'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      expect(markets[:data]).to be_an Array
      expect(markets[:data].count).to eq(2)
    end

    it 'can search for markets by name' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        name: 'Lame Place'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      expect(markets[:data]).to be_an Array
      expect(markets[:data].count).to eq(1)
    end
  end

  describe 'sad path - GET /api/v0/markets/search' do
    it 'returns an error if trying to search by city' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        city: 'Grand Junction'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end

    it 'returns an error if trying to search by city and name' do
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }
      q_params = {
        city: 'Grand Junction',
        name: 'Cool Place'
      }

      get '/api/v0/markets/search', headers: headers, params: q_params

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end
  end
end