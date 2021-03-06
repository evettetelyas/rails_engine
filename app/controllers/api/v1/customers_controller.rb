class Api::V1::CustomersController < ApplicationController

    def index
        render json: CustomerSerializer.new(Customer.all)
    end

    def show
        customer = Customer.find(params[:id])
        render json: CustomerSerializer.new(customer)
    end
end