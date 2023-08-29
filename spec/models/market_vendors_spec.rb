require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "relationships" do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end

  describe "validations" do
    before(:each) do
      market = create(:market)
      vendor = create(:vendor)
      MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
    end
    it { should validate_presence_of(:market_id) }
    it { should validate_presence_of(:vendor_id) }
    it { should validate_uniqueness_of(:market_id).scoped_to(:vendor_id) }
    it { should validate_uniqueness_of(:vendor_id).scoped_to(:market_id) }
  end
end