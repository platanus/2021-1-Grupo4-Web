FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    portions { "" }
    instructions { "MyText" }
    cook_minutes { "MyString" }
    int { "MyString" }
  end
end
