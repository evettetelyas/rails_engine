require 'rails_helper'

RSpec.describe "Invoices API" do
    it "returns all invoices" do
        create_list(:invoice, 3)

        get '/api/v1/invoices'

        invoices = JSON.parse(response.body)

        expect(invoices.count).to eq(3)
    end

    it "returns one invoice" do
        invoice = create(:invoice)

        get "/api/v1/invoices/#{invoice.id}"

        output = JSON.parse(response.body)

        expect(output["id"]).to eq(invoice.id)
        expect(output["merchant_id"]).to eq(invoice.merchant_id)
    end
end