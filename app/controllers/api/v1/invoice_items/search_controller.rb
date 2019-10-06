class Api::V1::InvoiceItems::SearchController < ApplicationController

    def show
        invoice_item = InvoiceItem.order_by_id.find_by(ii_params)
        render json: InvoiceItemSerializer.new(invoice_item)
    end

    def index
        invoice_items = InvoiceItem.order_by_id.where(ii_params)
        render json: InvoiceItemSerializer.new(invoice_items)
    end

    private

    def ii_params
        params.permit(:id,:status,:invoice_id,:item_id,:quantity,:unit_price,:created_at,:updated_at)
    end
end