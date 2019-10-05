require 'rails_helper'

RSpec.describe Api::V1::Merchants::SearchController do
    describe "merchant single finder" do
        before :each do
            @merchant = Merchant.create(name: "Larryland")
        end

        it "returns single merchant by name" do
            # response = Faraday.get("http://localhost:3000/api/v1/merchants/find?name=#{@merchant.name}")
            get "http://localhost:3000/api/v1/merchants/find?name=#{@merchant.name}"
            merch = JSON.parse(response.body)

            expect(merch["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(merch["data"]["attributes"]["name"]).to eq(@merchant.name)
        end

        it "returns a single merchant with upcase" do
            get "http://localhost:3000/api/v1/merchants/find?name=LARRYLAND"
            merch = JSON.parse(response.body)

            expect(merch["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(merch["data"]["attributes"]["name"]).to eq(@merchant.name)
        end

        it "returns single merchant by id" do
            get "http://localhost:3000/api/v1/merchants/find?id=#{@merchant.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(merch["data"]["attributes"]["name"]).to eq(@merchant.name)
        end

        it "returns single merchant by created at" do
            @merchant.update(created_at: "2012-03-27T14:54:05.000Z")
            get "http://localhost:3000/api/v1/merchants/find?created_at=#{@merchant.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(merch["data"]["attributes"]["name"]).to eq(@merchant.name)
        end

        it "returns single merchant by updated at" do
            @merchant.update(updated_at: "2012-03-27T14:54:05.000Z")
            get "http://localhost:3000/api/v1/merchants/find?updated_at=#{@merchant.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(merch["data"]["attributes"]["name"]).to eq(@merchant.name)
        end
    end

    describe "merchant multi finder" do
        before :each do
            @merchant = Merchant.create(name: "Larryland")
            @merchant_2 = Merchant.create(name: "Larryland")
        end

        it "returns all merchants by name" do
            # response = Faraday.get("http://localhost:3000/api/v1/merchants/find?name=#{@merchant.name}")
            get "http://localhost:3000/api/v1/merchants/find_all?name=Larryland"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all merchants with upcase" do
            get "http://localhost:3000/api/v1/merchants/find_all?name=LARRYLAND"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all merchants by created at" do
            @merchant.update(created_at: @merchant.created_at.xmlschema)
            @merchant_2.update(created_at: @merchant.created_at.xmlschema)

            get "http://localhost:3000/api/v1/merchants/find_all?created_at=#{@merchant.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all merchants by updated at" do
            @merchant.update(updated_at: @merchant.updated_at.xmlschema)
            @merchant_2.update(updated_at: @merchant.updated_at.xmlschema)

            get "http://localhost:3000/api/v1/merchants/find_all?updated_at=#{@merchant.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end
    end
end