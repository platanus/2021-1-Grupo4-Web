FactoryBot.define do
  factory :provider do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    country { "Chile" }
  end
end
