require 'rails_helper'

RSpec.describe Api::V1::Customers do
    describe "merchant relationship API endpoints" do
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

        it "returns that merchant's items" do
            get "http://localhost:3000/api/v1/merchants/#{@merchant.id}/items"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@item.id)
            expect(data["data"].first["attributes"]["name"]).to eq(@item.name)
        end

        it "returns that merchant's invoices" do
            get "http://localhost:3000/api/v1/merchants/#{@merchant.id}/invoices"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"].first["attributes"]["status"]).to eq(@invoice.status)
        end
    end
end