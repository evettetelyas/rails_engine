require 'rails_helper'

RSpec.describe "random single resource endpoints" do
    it "shows a random merchant" do
        create(:merchant)
        merchant = Merchant.find(Merchant.random)
        
        get '/api/v1/merchants/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(merchant.id)
        expect(data["data"]["attributes"]["name"]).to eq(merchant.name)
    end

    it "shows a random customer" do
        create(:customer)
        customer = Customer.find(Customer.random)
        
        get '/api/v1/customers/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(customer.id)
        expect(data["data"]["attributes"]["first_name"]).to eq(customer.first_name)
        expect(data["data"]["attributes"]["last_name"]).to eq(customer.last_name)
    end

    it "shows a random item" do
        create(:item)
        item = Item.find(Item.random)
        
        get '/api/v1/items/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(item.id)
        expect(data["data"]["attributes"]["name"]).to eq(item.name)
        expect(data["data"]["attributes"]["description"]).to eq(item.description)
    end

    it "shows a random invoice" do
        create(:invoice)
        invoice = Invoice.find(Invoice.random)
        
        get '/api/v1/invoices/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(invoice.id)
        expect(data["data"]["attributes"]["merchant_id"]).to eq(invoice.merchant_id)
        expect(data["data"]["attributes"]["customer_id"]).to eq(invoice.customer_id)
    end

    it "shows a random invoice_item" do
        create(:invoice_item)
        invoice_item = InvoiceItem.find(InvoiceItem.random)
        
        get '/api/v1/invoice_items/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(invoice_item.id)
        expect(data["data"]["attributes"]["invoice_id"]).to eq(invoice_item.invoice_id)
        expect(data["data"]["attributes"]["item_id"]).to eq(invoice_item.item_id)
        expect(data["data"]["attributes"]["quantity"]).to eq(invoice_item.quantity)
    end

    it "shows a random transaction" do
        merchant = create(:merchant)
        customer = create(:customer)
        invoice = create(:invoice, merchant: merchant, customer: customer)
        
        create(:transaction, invoice: invoice)
        transaction = Transaction.find(Transaction.random)
        
        get '/api/v1/transactions/random'
        
        data = JSON.parse(response.body)

        expect(data["data"]["attributes"]["id"]).to eq(transaction.id)
        expect(data["data"]["attributes"]["invoice_id"]).to eq(transaction.invoice_id)
        expect(data["data"]["attributes"]["result"]).to eq(transaction.result)
    end
end