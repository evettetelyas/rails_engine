require 'rails_helper'

RSpec.describe "Merchants API" do
    it "returns all merchants" do
        create_list(:merchant, 3)

        get '/api/v1/merchants'

        merchants = JSON.parse(response.body)

        expect(merchants["data"].count).to eq(3)
    end

    it "returns one merchant" do
        merchant = create(:merchant)

        get "/api/v1/merchants/#{merchant.id}"

        output = JSON.parse(response.body)

        expect(output["data"]["attributes"]["id"]).to eq(merchant.id)
        expect(output["data"]["attributes"]["name"]).to eq(merchant.name)
    end
end