class Api::V1::Merchants::RevenuesController < ApplicationController

    def show
        date = params["date"]
        revenue = Revenue.new(Merchant.date_revenue(date).first)
        render json: MerchantRevenueSerializer.new(revenue)
    end
end