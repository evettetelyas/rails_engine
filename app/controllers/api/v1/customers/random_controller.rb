class Api::V1::Customers::RandomController < ApplicationController

    def show
        customer = Customer.find(Customer.random)
        render json: CustomerSerializer.new(customer)
    end
    
end