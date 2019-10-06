class Transaction < ApplicationRecord
    belongs_to :invoice

    validates_presence_of :credit_card_number, :result
    validate :credit_card_expiration_date, if: :has_exp_date?

    scope :order_by_id, -> { order(:id) }

    def has_exp_date?
        self.credit_card_expiration_date?
    end

    def self.random
        Transaction.pluck(:id).sample(1).join
    end
end
