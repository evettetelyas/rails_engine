class Api::V1::Customers::InvoicesController < ApplicationController

    def index
       customer = Customer.find(params[:customer_id])
       invoices = Invoice.where(customer_id: customer.id)
       render json: InvoiceSerializer.new(invoices)
    end
end