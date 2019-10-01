class Api::V1::Customers::TransactionsController < ApplicationController

    def index
       customer = Customer.find(params[:customer_id])
       invoice_ids = Invoice.where(customer_id: customer.id).pluck("invoices.id")
       transactions = Transaction.where(invoice_id: invoice_ids)
       render json: TransactionSerializer.new(transactions)
    end
end