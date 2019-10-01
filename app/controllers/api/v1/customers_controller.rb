class Api::V1::CustomersController < ApplicationController

    def index
        render json: Customer.all
    end

    def show
        customer = Customer.find(params[:id])
        render json: customer
    end
end