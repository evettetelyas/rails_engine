require 'rails_helper'

RSpec.describe "Customers API" do
    it "returns all customers" do
        create_list(:customer, 3)

        get '/api/v1/customers'

        customers = JSON.parse(response.body)

        expect(customers.count).to eq(3)
    end

    it "returns one customer" do
        customer = create(:customer)

        get "/api/v1/customers/#{customer.id}"

        output = JSON.parse(response.body)

        expect(output["id"]).to eq(customer.id)
        expect(output["first_name"]).to eq(customer.first_name)
    end
end