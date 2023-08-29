require 'rails_helper'

RSpec.describe "Deleting a Vendor", type: :request do
  describe 'DELETE /api/v0/vendors/:id' do
    it 'happy path - can delete a vendor' do
      vendor = create(:vendor)

      expect(Vendor.count).to eq(1)

      delete "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)

      expect(Vendor.count).to eq(0)
      expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'sad path - invalid vendor id' do
      delete "/api/v0/vendors/000000"

      error_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect{Vendor.find(000000)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(error_details[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=000000")
    end
  end
end