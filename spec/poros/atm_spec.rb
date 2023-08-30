require 'rails_helper'

RSpec.describe Atm do
  describe 'initialize' do
    it 'exists' do
      atm_params = {
        name: 'ATM',
        address: '4530 32nd Ave',
        lat: 39.769547,
        lon: -104.958599,
        distance: 12.3
      }
      
      atm = Atm.new(atm_params)
      
      expect(atm).to be_a Atm
      expect(atm.id).to eq(nil)
      expect(atm.name).to eq('ATM')
      expect(atm.address).to eq('4530 32nd Ave')
      expect(atm.lat).to eq(39.769547)
      expect(atm.lon).to eq(-104.958599)
      expect(atm.distance).to eq(12.3)
    end
  end
end