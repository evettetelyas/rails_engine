require 'rails_helper'

RSpec.describe "Transactions API" do
    it "returns all transactions" do
        invoice = create(:invoice)
        create_list(:transaction, 3, invoice: invoice)

        get '/api/v1/transactions'

        transactions = JSON.parse(response.body)

        expect(transactions["data"].count).to eq(3)
    end

    it "returns one transaction" do
        invoice = create(:invoice)
        transaction = create(:transaction, invoice: invoice)

        get "/api/v1/transactions/#{transaction.id}"

        output = JSON.parse(response.body)

        expect(output["data"]["attributes"]["id"]).to eq(transaction.id)
        expect(output["data"]["attributes"]["invoice_id"]).to eq(transaction.invoice_id)
    end
end