require 'rails_helper'

RSpec.describe "Items API" do
    it "returns all items" do
        create_list(:item, 3)

        get '/api/v1/items'

        items = JSON.parse(response.body)

        expect(items["data"].count).to eq(3)
    end

    it "returns one item" do
        item = create(:item)

        get "/api/v1/items/#{item.id}"

        output = JSON.parse(response.body)

        expect(output["data"]["attributes"]["id"]).to eq(item.id)
        expect(output["data"]["attributes"]["name"]).to eq(item.name)
    end
end