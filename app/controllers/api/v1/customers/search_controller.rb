class Api::V1::Customers::SearchController < ApplicationController

    def show
        if params[:first_name]
            customer = Customer.find_by(first_name: params[:first_name])
        elsif params[:last_name]
            customer = Customer.find_by(last_name: params[:last_name])
        elsif params[:id]
            customer = Customer.find(params[:id])
        elsif params[:created_at]
            customer = Customer.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
            customer = Customer.find_by(updated_at: params[:updated_at])
        end
        render json: CustomerSerializer.new(customer)
    end

    def index
        if params[:first_name]
            customers = Customer.where(first_name: params[:first_name].capitalize)
        elsif params[:last_name]
            customers = Customer.where(last_name: params[:last_name].capitalize)
        elsif params[:id]
            customers = Customer.where(id: params[:id])
        elsif params[:created_at]
            customers = Customer.where(created_at: params[:created_at])
        elsif params[:updated_at]
            customers = Customer.where(updated_at: params[:updated_at])
        end
        render json: CustomerSerializer.new(customers) 
    end
end