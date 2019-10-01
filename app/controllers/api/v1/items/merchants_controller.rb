class Api::V1::Items::MerchantsController < ApplicationController

    def show
       item = Item.find(params[:item_id])
       merchant = Merchant.find_by(id: item.merchant_id)
       render json: MerchantSerializer.new(merchant)
    end
end