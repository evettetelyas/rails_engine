require 'rails_helper'

RSpec.describe Api::V1::Items do
    describe "items relationship API endpoints" do
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

        it "returns the associated invoice_items" do
            get "http://localhost:3000/api/v1/items/#{@item.id}/invoice_items"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"].first["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"].first["attributes"]["unit_price"]).to eq(@invoice_item.unit_price.to_f.to_s)
        end

        it "returns the associated merchant" do
            get "http://localhost:3000/api/v1/items/#{@item.id}/merchant"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@merchant.id)
            expect(data["data"]["attributes"]["name"]).to eq(@merchant.name)
        end
    end
end