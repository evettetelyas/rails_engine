FactoryBot.define do
  factory :item do
    name { "Thing" }
    description { "it's kewl" }
    unit_price { "10000" }
    merchant
  end
end
