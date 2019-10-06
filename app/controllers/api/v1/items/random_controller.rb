class Api::V1::Items::RandomController < ApplicationController

    def show
        item = Item.where(id: Item.random)
        render json: ItemSerializer.new(item)
    end
    
end