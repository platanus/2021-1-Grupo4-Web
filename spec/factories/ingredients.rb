FactoryBot.define do
  factory :ingredient do
    name { "MyString" }
    sku { "MyString" }
    price { 1 }
    currency { "MyString" }
    quantity { 1 }
    measure { "MyString" }
  end
end
