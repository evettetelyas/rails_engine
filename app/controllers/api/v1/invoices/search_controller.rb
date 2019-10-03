class Api::V1::Invoices::SearchController < ApplicationController

    def show
        invoice = Invoice.order_by_id.find_by(invoice_params)
        render json: InvoiceSerializer.new(invoice)
    end

    def index
        invoices = Invoice.order_by_id.where(invoice_params)
        render json: InvoiceSerializer.new(invoices)
    end

    private

    def invoice_params
        params.permit(:id,:status,:customer_id,:merchant_id,:created_at,:updated_at)
    end
end