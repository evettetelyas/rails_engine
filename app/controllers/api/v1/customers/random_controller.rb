class Api::V1::Customers::RandomController < ApplicationController

    def show
        customer = Customer.where(id: Customer.random)
        render json: CustomerSerializer.new(customer)
    end
    
end