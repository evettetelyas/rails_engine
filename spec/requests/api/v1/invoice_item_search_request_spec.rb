require 'rails_helper'
require 'date'

RSpec.describe Api::V1::InvoiceItems::SearchController do
    describe "invoice item single finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
        end

        it "returns single invoice_item by item_id" do
            get "http://localhost:3000/api/v1/invoice_items/find?item_id=#{@item.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single item by invoice_id" do
            get "http://localhost:3000/api/v1/invoice_items/find?invoice_id=#{@invoice.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single invoice_item by quantity" do
            get "http://localhost:3000/api/v1/invoice_items/find?quantity=#{@invoice_item.quantity}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single invoice_item by unit_price" do
            get "http://localhost:3000/api/v1/invoice_items/find?unit_price=#{@item.unit_price}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single invoice_item by created at" do
            @invoice_item.update(created_at: @invoice_item.created_at.xmlschema)
            get "http://localhost:3000/api/v1/invoice_items/find?created_at=#{@invoice_item.created_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end

        it "returns single invoice_item by updated at" do
            @invoice_item.update(updated_at: @invoice_item.updated_at.xmlschema)
            get "http://localhost:3000/api/v1/invoice_items/find?updated_at=#{@invoice_item.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@invoice_item.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@invoice_item.invoice_id)
            expect(data["data"]["attributes"]["quantity"]).to eq(@invoice_item.quantity)
            expect(data["data"]["attributes"]["unit_price"]).to eq(@item.unit_price.to_f.to_s)
        end
    end

    describe "invoice_item multi finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
            @invoice_item_2 = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
        end

        it "returns all invoice_items by item_id" do
            get "http://localhost:3000/api/v1/invoice_items/find_all?item_id=#{@item.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoice_items by created at" do
            @invoice_item.update(created_at: @invoice_item.created_at.xmlschema)
            @invoice_item_2.update(created_at: @invoice_item.created_at.xmlschema)

            get "http://localhost:3000/api/v1/invoice_items/find_all?created_at=#{@invoice_item.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoice_items by updated at" do
            @invoice_item.update(updated_at: @invoice_item.updated_at.xmlschema)
            @invoice_item_2.update(updated_at: @invoice_item.updated_at.xmlschema)

            get "http://localhost:3000/api/v1/invoice_items/find_all?updated_at=#{@invoice_item.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoice_items by invoice_id" do
            get "http://localhost:3000/api/v1/invoice_items/find_all?invoice_id=#{@invoice.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoice_items by unit_price" do
            get "http://localhost:3000/api/v1/invoice_items/find_all?unit_price=#{@invoice_item.unit_price}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all invoice_items by quantity" do
            get "http://localhost:3000/api/v1/invoice_items/find_all?quantity=#{@invoice_item.quantity}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end
    end
end