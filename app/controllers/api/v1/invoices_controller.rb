class Api::V1::InvoicesController < ApplicationController

    def index
        render json: InvoiceSerializer.new(Invoice.all)
    end

    def show
        invoice = Invoice.find(params[:id])
        render json: InvoiceSerializer.new(invoice)
    end
end