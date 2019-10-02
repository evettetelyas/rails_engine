class Api::V1::Merchants::PendingCustomersController < ApplicationController

    def index
        merchant = Merchant.find(params[:merchant_id])
        customers = Customer.find(merchant.pending_customers)
        render json: CustomerSerializer.new(customers)
    end
    
end