class Item < ApplicationRecord
    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items

    validates_presence_of :name, :description, :unit_price, :merchant_id, :id

    def best_day
        invoices.joins(:transactions)
        .where("transactions.result = 'success'")
        .select("sum(invoice_items.quantity), date(invoices.created_at)")
        .group("date(invoices.created_at)")
        .order("sum(invoice_items.quantity) desc, date(invoices.created_at) desc")
        .limit(1)
        .pluck("date(invoices.created_at)").first
    end

    def self.most_revenue(number)
        Invoice.joins(:transactions)
        .joins(:invoice_items)
        .where("transactions.result = 'success'")
        .select(:item_id)
        .group(:item_id)
        .order("sum(quantity * unit_price) desc")
        .limit(number)
        .pluck(:item_id)
    end
end
