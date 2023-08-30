require 'rails_helper'

RSpec.describe AtmFacade do
  describe 'ATM locations' do
    it 'returns nearest atms', :vcr do
      market = create(:market)

      atms = AtmFacade.get_atms(market)

      expect(atms).to be_an(Array)
      atms.each do |atm|
        expect(atm).to be_a(Atm)
        expect(atm.name).to be_a(String)
        expect(atm.address).to be_a(String)
        expect(atm.lat).to be_a(Float)
        expect(atm.lon).to be_a(Float)
        expect(atm.distance).to be_a(Float)
      end
    end
  end
end