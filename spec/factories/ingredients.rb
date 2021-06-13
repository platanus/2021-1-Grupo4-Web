FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    sku { Faker::Alphanumeric.alphanumeric(number: 10) }
    price { rand(50..300) * 10 }
    currency { "CLP" }
    user { create(:user) }
  end
end
