class Api::V1::Merchants::MostRevenuesController < ApplicationController

    def index
        number = params["quantity"]
        render json: MerchantSerializer.new(Merchant.find(Merchant.most_revenue(number)))
    end
end