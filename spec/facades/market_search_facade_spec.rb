require 'rails_helper'

RSpec.describe MarketSearchFacade do
  before(:each) do
    market1 = create(:market, name:'Cool Place', city: 'Grand Junction', state: 'Colorado')
    market2 = create(:market, name:'Okay Place', city: 'Grand Junction', state: 'Colorado')
    market3 = create(:market, name:'Lame Place', city: 'San Diegoo', state: 'California')
  end

  describe 'class methods' do
    it 'can search for markets by state, city, and name' do
      markets = MarketSearchFacade.search_markets('Cool Place', 'Grand Junction', 'Colorado')

      expect(markets.count).to eq(2)
      expect(markets).to be_an Array
      expect(markets.first).to be_a Market
      expect(markets.last).to be_a Market
      expect(markets.first.name).to eq('Cool Place')
      expect(markets.last.name).to eq('Okay Place')
    end
  end
end