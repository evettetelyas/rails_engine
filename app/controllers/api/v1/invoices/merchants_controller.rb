class Api::V1::Invoices::MerchantsController < ApplicationController

    def show
       invoice = Invoice.find(params[:invoice_id])
       merchant = Merchant.find_by(id: invoice.merchant_id)
       render json: MerchantSerializer.new(merchant)
    end
end