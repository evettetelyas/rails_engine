class Api::V1::Merchants::SearchController < ApplicationController

    def show
        merchant = Merchant.order_by_id.find_by(merchant_params)
        render json: MerchantSerializer.new(merchant)
    end

    def index
        merchants = Merchant.order_by_id.where(merchant_params)
        render json: MerchantSerializer.new(merchants)
    end

    private

    def merchant_params
        params.permit(:id,:name,:created_at,:updated_at)
    end
end

# class Api::V1::Merchants::SearchController < ApplicationController

#     def show
#         if params[:name]
#             merchant = Merchant.find_by(name: params[:name])
#         elsif params[:id]
#             merchant = Merchant.find(params[:id])
#         elsif params[:created_at]
#             merchant = Merchant.find_by(created_at: params[:created_at])
#         elsif params[:updated_at]
#             merchant = Merchant.find_by(updated_at: params[:updated_at])
#         end
#         render json: MerchantSerializer.new(merchant)
#     end

#     def index
#         if params[:name]
#             merchants = Merchant.where(name: params[:name])
#         elsif params[:id]
#             merchants = Merchant.where(id: params[:id])
#         elsif params[:created_at]
#             merchants = Merchant.where(created_at: params[:created_at])
#         elsif params[:updated_at]
#             merchants = Merchant.where(updated_at: params[:updated_at])
#         end
#         render json: MerchantSerializer.new(merchants)  
#     end
# end