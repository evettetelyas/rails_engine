class Api::V1::Invoices::RandomController < ApplicationController

    def show
        invoice = Invoice.where(id: Invoice.random)
        render json: InvoiceSerializer.new(invoice)
    end
    
end