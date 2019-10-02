class Item < ApplicationRecord
    belongs_to :merchant
    has_many :invoice_items
    has_many :items, through: :invoice_items

    validates_presence_of :name, :description, :unit_price, :merchant_id

    def best_day
        
    end
end
