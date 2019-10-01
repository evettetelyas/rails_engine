class Api::V1::Merchants::CustomersController < ApplicationController

    def favorite_customer
       merchant = Merchant.find(params[:merchant_id])
       render json: CustomerSerializer.new(Customer.find(merchant.favorite_customer))
    end
end