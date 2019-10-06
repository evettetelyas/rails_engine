class Api::V1::InvoiceItems::RandomController < ApplicationController

    def show
        invoice_item = InvoiceItem.find(InvoiceItem.random)
        render json: InvoiceItemSerializer.new(invoice_item)
    end
    
end