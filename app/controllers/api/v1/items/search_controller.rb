class Api::V1::Items::SearchController < ApplicationController

    def show
        if params[:name]
            item = Item.find_by(name: params[:name])
        elsif params[:id]
            item = Item.find(params[:id])
        elsif params[:created_at]
            item = Item.where(created_at: params[:created_at]).order(:id).first
        elsif params[:updated_at]
            item = Item.find_by(updated_at: params[:updated_at])
        elsif params[:description]
            item = Item.find_by(description: params[:description])
        elsif params[:unit_price]
            item = Item.find_by(unit_price: params[:unit_price])
        elsif params[:merchant_id]
            item = Item.find_by(merchant_id: params[:merchant_id])
        end
        render json: ItemSerializer.new(item)
    end

    def index
        if params[:name]
            items = Item.where(name: params[:name])
        elsif params[:id]
            items = Item.where(id: params[:id])
        elsif params[:created_at]
            items = Item.where(created_at: params[:created_at])
        elsif params[:updated_at]
            items = Item.where(updated_at: params[:updated_at])
        elsif params[:description]
            items = Item.where(description: params[:description])
        elsif params[:unit_price]
            items = Item.where(unit_price: (params[:unit_price].to_f))
        elsif params[:merchant_id]
            items = Item.where(merchant_id: params[:merchant_id]).order(:id)
        end
        render json: ItemSerializer.new(items)
    end
end