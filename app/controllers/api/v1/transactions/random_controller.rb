class Api::V1::Transactions::RandomController < ApplicationController

    def show
        transaction = Transaction.find(Transaction.random)
        render json: TransactionSerializer.new(transaction)
    end
    
end