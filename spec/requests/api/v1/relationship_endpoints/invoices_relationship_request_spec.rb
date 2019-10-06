require 'rails_helper'

RSpec.describe Api::V1::Invoices do
    describe "invoice relationship API endpoints" do
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

        it "returns that invoices's transactions" do
            get "http://localhost:3000/api/v1/invoices/#{@invoice.id}/transactions"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"].first["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
        end

        it "returns that invoice's invoice_items" do
            get "http://localhost:3000/api/v1/invoices/#{@invoice.id}/invoice_items"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"].first["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
        end

        it "returns that invoice's items" do
            get "http://localhost:3000/api/v1/invoices/#{@invoice.id}/items"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@item.id)
            expect(data["data"].first["attributes"]["name"]).to eq(@item.name)
        end

        it "returns that invoice's customer" do
            get "http://localhost:3000/api/v1/invoices/#{@invoice.id}/customer"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
            expect(data["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
        end

        it "returns that invoice's merchant" do
            get "http://localhost:3000/api/v1/invoices/#{@invoice.id}/merchant"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(data["data"]["attributes"]["name"]).to eq(@merchant.name)
        end
    end
end