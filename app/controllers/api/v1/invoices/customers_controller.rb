class Api::V1::Invoices::CustomersController < ApplicationController

    def show
       invoice = Invoice.find(params[:invoice_id])
       customer = Customer.find_by(id: invoice.customer_id)
       render json: CustomerSerializer.new(customer)
    end
end