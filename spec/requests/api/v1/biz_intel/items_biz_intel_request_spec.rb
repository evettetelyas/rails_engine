require 'rails_helper'

RSpec.describe Api::V1::Items do
    describe "items biz intel" do
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
        
        it "returns top x items ranked by total revenue" do
            qty = 1
            get "http://localhost:3000/api/v1/items/most_revenue?quantity=#{qty}"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]['id']).to eq(@item.id)
        end

        it "returns best day for item revenue" do
            get "http://localhost:3000/api/v1/items/#{@item.id}/best_day"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["best_day"]).to eq(DateTime.now.strftime('%F'))
        end
    end
end