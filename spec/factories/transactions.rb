FactoryBot.define do
  factory :transaction do
    credit_card_number { "1234567890123456" }
    result { "success" }
  end
end
