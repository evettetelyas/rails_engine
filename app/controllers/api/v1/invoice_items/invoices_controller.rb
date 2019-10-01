class Api::V1::InvoiceItems::InvoicesController < ApplicationController

    def show
       invoice_item = InvoiceItem.find(params[:invoice_item_id])
       invoice = Invoice.find_by(id: invoice_item.invoice_id)
       render json: InvoiceSerializer.new(invoice)
    end
end