class Api::V1::InvoiceItems::SearchController < ApplicationController

    def show
        if params[:status]
            invoice_item = InvoiceItem.find_by(status: params[:status])
        elsif params[:invoice_id]
            invoice_item = InvoiceItem.find_by(invoice_id: params[:invoice_id])
        elsif params[:item_id]
            invoice_item = InvoiceItem.find_by(item_id: params[:item_id])
        elsif params[:id]
            invoice_item = InvoiceItem.find(params[:id])
        elsif params[:quantity]
            invoice_item = InvoiceItem.find_by(quantity: params[:quantity])
        elsif params[:unit_price]
            invoice_item = InvoiceItem.find_by(unit_price: params[:unit_price].to_f)
        elsif params[:updated_at]
            invoice_item = InvoiceItem.find_by(updated_at: params[:updated_at])
        elsif params[:created_at]
            invoice_item = InvoiceItem.find_by(created_at: params[:created_at])
        end
        render json: InvoiceItemSerializer.new(invoice_item)
    end

    def index
        if params[:status]
            invoice_items = InvoiceItem.where(status: params[:status])
        elsif params[:invoice_id]
            invoice_items = InvoiceItem.where(invoice_id: params[:invoice_id]).order(:id)
        elsif params[:item_id]
            invoice_items = InvoiceItem.where(item_id: params[:item_id])
        elsif params[:id]
            invoice_items = InvoiceItem.where(id: params[:id])
        elsif params[:quantity]
            invoice_items = InvoiceItem.where(quantity: params[:quantity])
        elsif params[:unit_price]
            invoice_items = InvoiceItem.where(unit_price: params[:unit_price].to_f)
        elsif params[:updated_at]
            invoice_items = InvoiceItem.where(updated_at: params[:updated_at])
        elsif params[:created_at]
            invoice_items = InvoiceItem.where(created_at: params[:created_at])
        end
        render json: InvoiceItemSerializer.new(invoice_items)
    end
end