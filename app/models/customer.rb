class Customer < ApplicationRecord
    validates_presence_of :first_name, :last_name

    has_many :invoices
    has_many :transactions, through: :invoices

    scope :order_by_id, -> { order(:id) }

    def favorite_merchant
        invoices.joins(:transactions)
        .where("transactions.result = 'success'")
        .select("count(*), invoices.merchant_id")
        .group(:merchant_id)
        .order("count(*) desc")
        .limit(1)
        .pluck(:merchant_id).first
    end

end
