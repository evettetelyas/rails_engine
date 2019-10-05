require 'rails_helper'
require 'date'

RSpec.describe Api::V1::Merchants do
    describe "merchant biz intel" do
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

        it "returns the favorite customer for a single merchant" do
            get "http://localhost:3000/api/v1/merchants/#{@merchant.id}/favorite_customer"
            data = JSON.parse(response.body)
            
            expect(data["data"]["attributes"]["id"]).to eq(@customer.id)
        end
        
        it "returns top x merchants ranked by total revenue" do
            qty = 1
            get "http://localhost:3000/api/v1/merchants/most_revenue?quantity=#{qty}"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]['id']).to eq(@merchant.id)
        end

        it "returns total revenue for x day across all merchants" do
            date = DateTime.now.strftime('%F')
            get "http://localhost:3000/api/v1/merchants/revenue?date=#{date}"
            data = JSON.parse(response.body)
            
            expect(data["data"]["attributes"]["total_revenue"]).to eq("13.98")
        end

        it "returns customers with pending invoices" do
            invoice_2 = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            get "http://localhost:3000/api/v1/merchants/#{@merchant.id}/customers_with_pending_invoices"
            data = JSON.parse(response.body)

            expect(data["data"].count).to eq(1)
            expect(data["data"].first["attributes"]["id"]).to eq(@customer.id)
        end
    end
end