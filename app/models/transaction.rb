class Transaction < ApplicationRecord
    belongs_to :invoice

    validates_presence_of :credit_card_number, :result

    scope :order_by_id, -> { order(:id) }

end
