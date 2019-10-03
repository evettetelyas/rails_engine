class Api::V1::Items::MostRevenuesController < ApplicationController

    def index
        number = params[:quantity].to_i
        render json: ItemSerializer.new(Item.find(Item.most_revenue(number)))
    end
end