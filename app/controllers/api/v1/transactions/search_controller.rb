class Api::V1::Transactions::SearchController < ApplicationController

    def show
        if params[:result]
            transaction = Transaction.find_by(result: params[:result])
        elsif params[:invoice_id]
            transaction = Transaction.find_by(invoice_id: params[:invoice_id])
        elsif params[:id]
            transaction = Transaction.find(params[:id])
        elsif params[:credit_card_number]
            transaction = Transaction.find_by(credit_card_number: params[:credit_card_number])
        elsif params[:updated_at]
            transaction = Transaction.find_by(updated_at: params[:updated_at])
        elsif params[:created_at]
            transaction = Transaction.find_by(updated_at: params[:created_at])
        end
        render json: TransactionSerializer.new(transaction)
    end

    def index
        if params[:result]
            transactions = Transaction.where(result: params[:result])
        elsif params[:invoice_id]
            transactions = Transaction.where(invoice_id: params[:invoice_id]).order(:id)
        elsif params[:id]
            transactions = Transaction.where(id: params[:id])
        elsif params[:credit_card_number]
            transactions = Transaction.where(credit_card_number: params[:credit_card_number])
        elsif params[:updated_at]
            transactions = Transaction.where(updated_at: params[:updated_at])
        elsif params[:created_at]
            transactions = Transaction.where(updated_at: params[:created_at])
        end
        render json: TransactionSerializer.new(transactions)
    end
end