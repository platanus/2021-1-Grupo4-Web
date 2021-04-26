FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    portions { rand(1..6) }
    instructions { Faker::Lorem.paragraph(sentence_count: 10) }
    cook_minutes { rand(10..180) }
    user { create(:user) }
  end
end
