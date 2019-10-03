class Api::V1::InvoiceItemsController < ApplicationController

    def index
        render json: InvoiceItemSerializer.new(InvoiceItem.all)
    end

    def show
        invoice_item = InvoiceItem.find(params[:id])
        render json: InvoiceItemSerializer.new(invoice_item)
    end
end