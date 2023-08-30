require 'rails_helper'

RSpec.describe AtmFacade do
  describe 'ATM locations', :vcr do
  #   it 'initailize', :vcr do
  #     market = create(:market)
  #     atm_facade = AtmFacade.new(market)

  #     expect(atm_facade).to be_a AtmFacade
  #   end

    it 'can retrieve atms close to given coordinates' do
      market = create(:market)
      atm_facade = AtmFacade.new(market)

      expect(atm_facade.atms_near_market).to be_a Array
      expect(atm_facade.atms_near_market.first).to be_a Atm
    end
  end
end