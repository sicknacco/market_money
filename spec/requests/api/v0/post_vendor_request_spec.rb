require 'rails_helper'

RSpec.describe "Creating a new vendor", type: :request do
  describe 'POST /api/v0/vendors' do
    it 'happy path - can create a new vendor in the body of the request' do
      vendor_params = {
        name: "Super Cool Vendor",
        description: "We sell super cool things",
        contact_name: "Cool Joe",
        contact_phone: "123-456-7890",
        credit_accepted: true
      }
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      vendor = JSON.parse(response.body, symbolize_names: true)
      new_vendor = Vendor.last

      expect(Vendor.count).to eq(1)
      expect(vendor).to be_a Hash
      expect(vendor).to have_key(:data)
      expect(vendor[:data]).to be_a Hash
      expect(vendor[:data]).to have_key(:id)
      expect(vendor[:data][:id]).to eq(new_vendor.id.to_s)
      expect(vendor[:data]).to have_key(:type)
      expect(vendor[:data][:type]).to eq('vendor')
      expect(vendor[:data]).to have_key(:attributes)
      expect(vendor[:data][:attributes]).to be_a Hash

      expect(vendor[:data][:attributes]).to have_key(:name)
      expect(vendor[:data][:attributes][:name]).to eq(new_vendor.name)
      expect(vendor[:data][:attributes]).to have_key(:description)
      expect(vendor[:data][:attributes][:description]).to eq(new_vendor.description)
      expect(vendor[:data][:attributes]).to have_key(:contact_name)
      expect(vendor[:data][:attributes][:contact_name]).to eq(new_vendor.contact_name)
      expect(vendor[:data][:attributes]).to have_key(:contact_phone)
      expect(vendor[:data][:attributes][:contact_phone]).to eq(new_vendor.contact_phone)
      expect(vendor[:data][:attributes]).to have_key(:credit_accepted)
      expect(vendor[:data][:attributes][:credit_accepted]).to eq(new_vendor.credit_accepted)
    end

    it 'sad path - missing required attributes' do
      vendor_params = {
        name: "Buzzy Bees",
        description: "local honey and wax products",
        credit_accepted: true
      }
      headers = {
        CONTENT_TYPE: "application/json",
        ACCEPT: "application/json"
      }

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to be_an Array
      expect(error_data[:errors][0]).to be_a Hash
      expect(error_data[:errors][0]).to have_key(:detail)
      expect(error_data[:errors][0][:detail]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
    end
  end
end