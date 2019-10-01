class Api::V1::Transactions::InvoicesController < ApplicationController

    def show
       transaction = Transaction.find(params[:transaction_id])
       invoice = Invoice.find(transaction.invoice_id)
       render json: InvoiceSerializer.new(invoice)
    end
end