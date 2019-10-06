require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems do
    describe "invoice_items relationship API endpoints" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @customer_2 = Customer.create(first_name: "Pierre", last_name: "Escargot")
            @merchant = Merchant.create(name: "LarryLand")
            @merchant_2 = Merchant.create(name: "LuLu's Cat Party")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6.99)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
            @transaction = Transaction.create(invoice: @invoice, credit_card_number: '123456789', result: 'success')
        end

        it "returns the associated invoice" do
            get "http://localhost:3000/api/v1/invoice_items/#{@invoice_item.id}/invoice"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end

        it "returns the associated item" do
            get "http://localhost:3000/api/v1/invoice_items/#{@invoice_item.id}/item"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@item.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
            expect(data["data"]["attributes"]["description"]).to eq(@item.description)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end
    end
end