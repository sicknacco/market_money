require 'rails_helper'

RSpec.describe AtmService do
  describe 'ATM locations' do
    it 'can retrieve atms close to given coordinates' do
      atms = AtmService.get_atms(39.7392, -104.9903)

      expect(response).to be_a Hash
      
    end
  end
end