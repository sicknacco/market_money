require 'rails_helper'

RSpec.describe AtmService do
  describe 'ATM locations' do
    it 'can retrieve atms close to given coordinates' do
      atms = AtmService.get_atms(39.7392, -104.9903)

      expect(atms).to be_a Hash
      atms[:results].each do |atm|
        expect(atm[:address]).to have_key(:freeformAddress)
        expect(atm[:address][:freeformAddress]).to be_a String
        expect(atm[:position]).to have_key(:lat)
        expect(atm[:position][:lat]).to be_a Float
        expect(atm[:position]).to have_key(:lon)
        expect(atm[:position][:lon]).to be_a Float
        expect(atm).to have_key(:dist)
        expect(atm[:dist]).to be_a Float
      end
    end
  end
end