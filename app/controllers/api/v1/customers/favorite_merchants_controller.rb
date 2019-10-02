class Api::V1::Customers::FavoriteMerchantsController < ApplicationController

    def show
        customer = Customer.find(params[:customer_id])
        fave = Merchant.find(customer.favorite_merchant)
        render json: MerchantSerializer.new(fave)
    end
end