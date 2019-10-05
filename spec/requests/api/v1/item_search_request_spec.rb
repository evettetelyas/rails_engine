require 'rails_helper'
require 'date'

RSpec.describe Api::V1::Items::SearchController do
    describe "item single finder" do
        before :each do
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
        end

        it "returns single item by name" do
            get "http://localhost:3000/api/v1/items/find?name=#{@item.name}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by merchant_id" do
            get "http://localhost:3000/api/v1/items/find?merchant_id=#{@merchant.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by description" do
            get "http://localhost:3000/api/v1/items/find?description=#{@item.description}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns a single item with upcase" do
            get "http://localhost:3000/api/v1/items/find?name=PUGGO TREATOS"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by id" do
            get "http://localhost:3000/api/v1/items/find?id=#{@item.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by created at" do
            @item.update(created_at: @item.created_at.xmlschema)
            get "http://localhost:3000/api/v1/items/find?created_at=#{@item.created_at}"
            data = JSON.parse(response.body)
            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by updated at" do
            @item.update(updated_at: @item.updated_at.xmlschema)
            get "http://localhost:3000/api/v1/items/find?updated_at=#{@item.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["name"]).to eq(@item.name)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end
    end

    describe "item multi finder" do
        before :each do
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @item_2 = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
        end

        it "returns all items by name" do
            get "http://localhost:3000/api/v1/items/find_all?name=puggo treatos"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all items by created at" do
            @item.update(created_at: @item.created_at.xmlschema)
            @item_2.update(created_at: @item.created_at.xmlschema)

            get "http://localhost:3000/api/v1/items/find_all?created_at=#{@item.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all items by updated at" do
            @item.update(updated_at: @item.updated_at.xmlschema)
            @item_2.update(updated_at: @item.updated_at.xmlschema)

            get "http://localhost:3000/api/v1/items/find_all?updated_at=#{@item.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all items by merchant_id" do
            get "http://localhost:3000/api/v1/items/find_all?merchant_id=#{@merchant.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all items by description" do
            get "http://localhost:3000/api/v1/items/find_all?description=#{@item.description}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end
    end
end