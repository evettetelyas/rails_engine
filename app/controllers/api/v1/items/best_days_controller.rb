class Api::V1::Items::BestDaysController < ApplicationController

    def show
        item = Item.find(params[:item_id])
        render json: BestDayItemSerializer.new(item)
    end
end