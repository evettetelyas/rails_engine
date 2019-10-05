require 'rails_helper'

RSpec.describe Api::V1::Customers::SearchController do
    describe "customer single finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
        end

        it "returns single customer by first_name" do
            get "http://localhost:3000/api/v1/customers/find?first_name=#{@customer.first_name}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "returns single customer by last_name" do
            get "http://localhost:3000/api/v1/customers/find?last_name=#{@customer.last_name}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "returns a single customer with upcase" do
            get "http://localhost:3000/api/v1/customers/find?name=LARRY"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "returns single customer by id" do
            get "http://localhost:3000/api/v1/customers/find?id=#{@customer.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "returns single customer by created at" do
            @customer.update(created_at: "2012-03-27T14:54:05.000Z")
            get "http://localhost:3000/api/v1/customers/find?created_at=#{@customer.created_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "returns single customer by updated at" do
            @customer.update(updated_at: "2012-03-27T14:54:05.000Z")
            get "http://localhost:3000/api/v1/customers/find?updated_at=#{@customer.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
            expect(data["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
        end
    end

    describe "customer multi finder" do
        before :each do
            @customer_1 = Customer.create(first_name: "Larry", last_name: "McFatty")
            @customer_2 = Customer.create(first_name: "Larry", last_name: "McFatty")
        end

        it "returns all customers by first name" do
            get "http://localhost:3000/api/v1/customers/find_all?frist_name=larry"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(2)
        end

        it "returns all customers by last name" do
            get "http://localhost:3000/api/v1/customers/find_all?Last_name=mcfatty"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(2)
        end

        it "returns all customers by created at" do
            @customer_1.update(created_at: "2012-03-27T14:54:05.000Z")
            @customer_2.update(created_at: "2012-03-27T14:54:05.000Z")

            get "http://localhost:3000/api/v1/customers/find_all?created_at=#{@customer_1.created_at}"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(2)
        end

        it "returns all customers by updated at" do
            @customer_1.update(updated_at: "2012-03-27T14:54:05.000Z")
            @customer_2.update(updated_at: "2012-03-27T14:54:05.000Z")

            get "http://localhost:3000/api/v1/customers/find_all?updated_at=#{@customer_1.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(2)
        end
    end
end