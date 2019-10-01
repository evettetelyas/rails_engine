FactoryBot.define do
  factory :item do
    name { "Thing" }
    description { "it's kewl" }
    unit_price { "100.00" }
    merchant
  end
end
