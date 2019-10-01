class Api::V1::Invoices::TransactionsController < ApplicationController

    def index
       invoice = Invoice.find(params[:invoice_id])
       transactions = Transaction.where(invoice_id: invoice.id)
       render json: TransactionSerializer.new(transactions)
    end
end