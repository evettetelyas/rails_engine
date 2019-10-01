class Api::V1::Invoices::ItemsController < ApplicationController

    def index
       invoice = Invoice.find(params[:invoice_id])
       item_ids = InvoiceItem.where(invoice_id: invoice.id).pluck(:item_id)
       items = Item.find(item_ids)
       render json: ItemSerializer.new(items)
    end
end