require 'rails_helper'

RSpec.describe "Market API", type: :request do
  describe "GET /api/v0/markets" do
    it "returns all markets" do
      create_list(:market, 10)

      get "/api/v0/markets"

      expect(response).to be_successful

      markets = JSON.parse(response.body)
    end
  end
end