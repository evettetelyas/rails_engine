class Api::V1::Merchants::RandomController < ApplicationController

    def show
        merchant = Merchant.where(id: Merchant.random)
        render json: MerchantSerializer.new(merchant)
    end
    
end