class Api::V1::Invoices::RandomController < ApplicationController

    def show
        invoice = Invoice.find(Invoice.random)
        render json: InvoiceSerializer.new(invoice)
    end
    
end