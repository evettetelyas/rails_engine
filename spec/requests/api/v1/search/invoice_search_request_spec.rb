require 'rails_helper'

RSpec.describe Api::V1::Invoices::SearchController do
    describe "invoice single finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
        end

        it "returns single invoice by merchant_id" do
            get "http://localhost:3000/api/v1/invoices/find?merchant_id=#{@merchant.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end

        it "returns single invoice by customer_id" do
            get "http://localhost:3000/api/v1/invoices/find?customer_id=#{@customer.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end

        it "returns single invoice by status" do
            get "http://localhost:3000/api/v1/invoices/find?status=#{@invoice.status}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end

        it "returns single invoice by created at" do
            @invoice.update(created_at: @invoice.created_at.xmlschema)
            get "http://localhost:3000/api/v1/invoices/find?created_at=#{@invoice.created_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end

        it "returns single invoice by updated at" do
            @invoice.update(updated_at: @invoice.updated_at.xmlschema)
            get "http://localhost:3000/api/v1/invoices/find?updated_at=#{@invoice.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice.id)
            expect(data["data"]["attributes"]["merchant_id"]).to eq(@invoice.merchant_id)
            expect(data["data"]["attributes"]["customer_id"]).to eq(@invoice.customer_id)
            expect(data["data"]["attributes"]["status"]).to eq(@invoice.status)
        end
    end

    describe "invoice multi finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_2 = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
        end

        it "returns all invoices by merchant_id" do
            get "http://localhost:3000/api/v1/invoices/find_all?merchant_id=#{@merchant.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoices by created at" do
            @invoice.update(created_at: @invoice.created_at.xmlschema)
            @invoice_2.update(created_at: @invoice.created_at.xmlschema)

            get "http://localhost:3000/api/v1/invoices/find_all?created_at=#{@invoice.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoices by updated at" do
            @invoice.update(updated_at: @invoice.updated_at.xmlschema)
            @invoice_2.update(updated_at: @invoice.updated_at.xmlschema)

            get "http://localhost:3000/api/v1/invoices/find_all?updated_at=#{@invoice.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoices by customer_id" do
            get "http://localhost:3000/api/v1/invoices/find_all?customer_id=#{@customer.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoices by status" do
            get "http://localhost:3000/api/v1/invoices/find_all?status=#{@invoice.status}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end
    end
end