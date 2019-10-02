class Api::V1::Merchants::FavoriteCustomersController < ApplicationController

    def show
        merchant = Merchant.find(params[:merchant_id])
        fave = Customer.find(merchant.favorite_customer)
        render json: CustomerSerializer.new(fave)
    end
    
end