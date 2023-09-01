require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_phone) }
    it { should allow_value(true).for(:credit_accepted) }
    it { should allow_value(false).for(:credit_accepted) }
    it { should_not allow_value(nil).for(:credit_accepted) }
  end

  describe 'instance methods' do
    describe '#states_sold_in' do
      it 'returns an array of states when markets are associated with the vendor' do
        vendor = create(:vendor)
        market_1 = create(:market, state: 'Colorado')
        market_2 = create(:market, state: 'New York')
        MarketVendor.create!(market_id: market_1.id, vendor_id: vendor.id)
        MarketVendor.create!(market_id: market_2.id, vendor_id: vendor.id)
        
        expect(vendor.states_sold_in).to eq(['Colorado', 'New York'])
      end
      
      it 'returns an array when a vendor is associated with a single state' do
        vendor = create(:vendor)
        market_1 = create(:market, state: 'Colorado')
        MarketVendor.create!(market_id: market_1.id, vendor_id: vendor.id)
        
        expect(vendor.states_sold_in).to eq(['Colorado'])
      end

      it 'returns an empty array when no markets are associated with the vendor' do
        vendor = create(:vendor)
        expect(vendor.states_sold_in).to eq([])
      end
    end
  end
end