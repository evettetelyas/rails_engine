class Api::V1::TransactionsController < ApplicationController

    def index
        render json: TransactionSerializer.new(Transaction.all)
    end

    def show
        transaction = Transaction.find(params[:id])
        render json: TransactionSerializer.new(transaction)
    end
end