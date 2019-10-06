class Api::V1::Items::RandomController < ApplicationController

    def show
        item = Item.find(Item.random)
        render json: ItemSerializer.new(item)
    end
    
end