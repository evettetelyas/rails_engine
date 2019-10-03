class Api::V1::Customers::SearchController < ApplicationController

    def show
        customer = Customer.order_by_id.find_by(customer_params)
        render json: CustomerSerializer.new(customer)
    end

    def index
        customers = Customer.order_by_id.where(customer_params)
        render json: CustomerSerializer.new(customers)
    end

    private

    def customer_params
        params.permit(:id,:first_name,:last_name,:created_at,:updated_at)
    end
end