class Api::V1::TransactionsController < ApplicationController

    def index
        render json: Transaction.all
    end

    def show
        transaction = Transaction.find(params[:id])
        render json: transaction
    end
end