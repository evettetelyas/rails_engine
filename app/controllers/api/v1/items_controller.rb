class Api::V1::ItemsController < ApplicationController

    def index
        render json: ItemSerializer.new(Item.all)
    end

    def show
        if params[:id]
            item = Item.find(params[:id])
        else
            item = Item.find(params[:item_id])
        end
        render json: ItemSerializer.new(item)
    end
end