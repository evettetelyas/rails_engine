class Api::V1::Merchants::InvoicesController < ApplicationController

    def index
       merchant = Merchant.find(params[:merchant_id])
       invoices = Invoice.where(merchant_id: merchant.id)
       render json: InvoiceSerializer.new(invoices)
    end
end