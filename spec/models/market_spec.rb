require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end

  describe "instance methods" do
    it "#vendor_count" do
     market1 = create(:market)
     market2 = create(:market)
     vendors1 = create_list(:vendor, 3)

     mv1 = MarketVendor.create!(market_id: market1.id, vendor_id: vendors1[0].id)
     mv2 = MarketVendor.create!(market_id: market1.id, vendor_id: vendors1[1].id)

     mv3 = MarketVendor.create!(market_id: market2.id, vendor_id: vendors1[2].id)

     expect(market1.vendor_count).to eq(2)
     expect(market2.vendor_count).to eq(1)
    end
  end
end