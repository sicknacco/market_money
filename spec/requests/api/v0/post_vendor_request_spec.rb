require 'rails_helper'

RSpec.describe "Creating a new vendor", type: :request do
  describe 'POST /api/v0/vendors' do
    it 'can create a new vendor in the body of the request' do
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
    end
  end
end