class Api::V1::Transactions::SearchController < ApplicationController

    def show
        transaction = Transaction.order_by_id.find_by(transaction_params)
        render json: TransactionSerializer.new(transaction)
    end

    def index
        transactions = Transaction.order_by_id.where(transaction_params)
        render json: TransactionSerializer.new(transactions)
    end

    private

    def transaction_params
        params.permit(:id,:invoice_id,:result,:credit_card_number,:created_at,:updated_at)
    end
end