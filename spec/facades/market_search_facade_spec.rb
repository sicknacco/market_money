require 'rails_helper'

RSpec.describe MarketSearchFacade do
  before(:each) do
    @market1 = create(:market, name:'Cool Place', city: 'Grand Junction', state: 'Colorado')
    @market2 = create(:market, name:'Okay Place', city: 'Grand Junction', state: 'Colorado')
    @market3 = create(:market, name:'Lame Place', city: 'San Diegoo', state: 'California')
  end

  describe 'class methods' do
    it 'can search for markets by state, city, and name' do
      market = MarketSearchFacade.search_markets('Cool Place', 'Grand Junction', 'Colorado')

      expect(MarketSearchFacade.search_markets('Cool Place', 'Grand Junction', 'Colorado')).to eq([@market1])
      expect(MarketSearchFacade.search_markets('Cool Place', 'Grand Junction', 'Colorado')).to_not eq([@market3])

      expect(MarketSearchFacade.search_markets('Okay Place', 'Grand Junction', 'Colorado')).to eq([@market2])
      expect(MarketSearchFacade.search_markets('Okay Place', 'Grand Junction', 'Colorado')).to_not eq([@market3])
    end
  end
end