class Api::V1::InvoiceItems::ItemsController < ApplicationController

    def show
       invoice_item = InvoiceItem.find(params[:invoice_item_id])
       item = Item.find_by(id: invoice_item.item_id)
       render json: ItemSerializer.new(item)
    end
end