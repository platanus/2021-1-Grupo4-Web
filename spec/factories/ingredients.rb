FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    sku { Faker::Alphanumeric.alphanumeric(number: 10) }
    price { rand(50..300) * 10 }
    currency { "CLP" }
    quantity { rand(1..3) }
    measure { "kg" }
    user { create(:user) }
  end
end
