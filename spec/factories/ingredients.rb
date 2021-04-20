FactoryBot.define do
  factory :ingredient do
    name { "Some ingredient name" }
    SKU { "0000" }
    price { 1000 }
    currency { "CLP" }
    quantity { 1 }
    measure { "kg" }
  end
end
