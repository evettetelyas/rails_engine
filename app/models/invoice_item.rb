class InvoiceItem < ApplicationRecord
    belongs_to :item
    belongs_to :invoice

    validates_presence_of :item_id, :invoice_id, :quantity, :unit_price

    scope :order_by_id, -> { order(:id) }

    def self.random
        InvoiceItem.pluck(:id).sample(1).join
    end
end
