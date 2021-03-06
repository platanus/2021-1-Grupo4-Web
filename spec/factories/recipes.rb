FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    portions { rand(1..6) }
    cook_minutes { rand(10..180) }
    user { create(:user) }
  end
end
