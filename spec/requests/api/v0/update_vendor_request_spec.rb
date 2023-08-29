require 'rails_helper'

RSpec.describe "Updating a Vendor", type: :request do
  describe 'PATCH /api/v0/vendors/:id' do
    it 'happy path - can update a vendor in the body of the request' do
      vendor = create(:vendor)
      vendor_params = {
        contact_name: "Kimberly Couwer",
        credit_accepted: false
      }
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }

      patch "/api/v0/vendors/#{vendor.id}", headers: headers, params: JSON.generate(vendor_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      vendor = Vendor.last
      
      expect(vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
    end

    it 'sad path - invlaid vendor id' do
      vendor_params = {
        contact_name: "Kimberly Couwer",
        credit_accepted: false
      }
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }

      patch "/api/v0/vendors/000000", headers: headers, params: JSON.generate(vendor_params)

      error_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect{Vendor.find(000000)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(error_details[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=000000")
    end
  end
end