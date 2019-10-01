FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { "100.00" }
    item
    invoice
  end
end
