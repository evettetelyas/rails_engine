class Api::V1::Transactions::RandomController < ApplicationController

    def show
        transaction = Transaction.where(id: Transaction.random)
        render json: TransactionSerializer.new(transaction)
    end
    
end