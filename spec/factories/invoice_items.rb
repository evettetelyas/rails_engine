FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { "10000" }
    item
    invoice
  end
end
