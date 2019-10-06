class Invoice < ApplicationRecord
    belongs_to :customer
    belongs_to :merchant
    has_many :transactions
    has_many :invoice_items
    has_many :items, through: :invoice_items

    validates_presence_of :status

    scope :order_by_id, -> { order(:id) }

    def self.random
        Invoice.pluck(:id).sample(1)
    end

end
