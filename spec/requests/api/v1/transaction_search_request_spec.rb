require 'rails_helper'
require 'date'

RSpec.describe Api::V1::Transactions::SearchController do
    describe "transaction single finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
            @transaction = Transaction.create(invoice: @invoice, credit_card_number: '123456789', result: 'success')
        end

        it "returns single transaction by invoice_id" do
            get "http://localhost:3000/api/v1/transactions/find?invoice_id=#{@invoice.id}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
            expect(data["data"]["attributes"]["credit_card_number"]).to eq(@transaction.credit_card_number)
            expect(data["data"]["attributes"]["result"]).to eq(@transaction.result)
        end

        it "returns single transaction by cc_number" do
            get "http://localhost:3000/api/v1/transactions/find?credit_card_number=#{@transaction.credit_card_number}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
            expect(data["data"]["attributes"]["credit_card_number"]).to eq(@transaction.credit_card_number)
            expect(data["data"]["attributes"]["result"]).to eq(@transaction.result)
        end

        it "returns single transaction by result" do
            get "http://localhost:3000/api/v1/transactions/find?result=#{@transaction.result}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
            expect(data["data"]["attributes"]["credit_card_number"]).to eq(@transaction.credit_card_number)
            expect(data["data"]["attributes"]["result"]).to eq(@transaction.result)
        end

        it "returns single transaction by created at" do
            @transaction.update(created_at: @transaction.created_at.xmlschema)
            get "http://localhost:3000/api/v1/transactions/find?created_at=#{@transaction.created_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
            expect(data["data"]["attributes"]["credit_card_number"]).to eq(@transaction.credit_card_number)
            expect(data["data"]["attributes"]["result"]).to eq(@transaction.result)
        end

        it "returns single transaction by updated at" do
            @transaction.update(updated_at: @transaction.updated_at.xmlschema)
            get "http://localhost:3000/api/v1/transactions/find?updated_at=#{@transaction.updated_at}"
            data = JSON.parse(response.body)

            expect(data["data"]["attributes"]["id"]).to eq(@transaction.id)
            expect(data["data"]["attributes"]["invoice_id"]).to eq(@transaction.invoice_id)
            expect(data["data"]["attributes"]["credit_card_number"]).to eq(@transaction.credit_card_number)
            expect(data["data"]["attributes"]["result"]).to eq(@transaction.result)
        end
    end

    describe "transactions multi finder" do
        before :each do
            @customer = Customer.create(first_name: "Larry", last_name: "McFatty")
            @merchant = Merchant.create(name: "LarryLand")
            @item = @merchant.items.create(name: "Puggo Treatos", description: "Little Bitty Yum Yums", unit_price: 6)
            @invoice = Invoice.create(merchant: @merchant, customer: @customer, status: 'shipped')
            @invoice_item = InvoiceItem.create(item: @item, invoice: @invoice, quantity: 2, unit_price: @item.unit_price)
            @transaction = Transaction.create(invoice: @invoice, credit_card_number: '123456789', result: 'success')
            @transaction_2 = Transaction.create(invoice: @invoice, credit_card_number: '123456789', result: 'success')
        end

        it "returns all transactions by invoice_id" do
            get "http://localhost:3000/api/v1/transactions/find_all?invoice_id=#{@invoice.id}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all transactions by created at" do
            @transaction.update(created_at: @transaction.created_at.xmlschema)
            @transaction_2.update(created_at: @transaction.created_at.xmlschema)

            get "http://localhost:3000/api/v1/transactions/find_all?created_at=#{@transaction.created_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all transactions by updated at" do
            @transaction.update(updated_at: @transaction.updated_at.xmlschema)
            @transaction_2.update(updated_at: @transaction.updated_at.xmlschema)

            get "http://localhost:3000/api/v1/transactions/find_all?updated_at=#{@transaction.updated_at}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end

        it "returns all transactions by cc_number" do
            get "http://localhost:3000/api/v1/transactions/find_all?customer_id=#{@transaction.credit_card_number}"
            merch = JSON.parse(response.body)

            expect(merch["data"].count).to eq(2)
        end
    end
end