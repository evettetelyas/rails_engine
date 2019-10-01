class Api::V1::Invoices::InvoiceItemsController < ApplicationController

    def index
       invoice = Invoice.find(params[:invoice_id])
       invoice_items = InvoiceItem.where(invoice_id: invoice.id)
       render json: InvoiceItemSerializer.new(invoice_items)
    end
end