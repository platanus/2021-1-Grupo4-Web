FactoryBot.define do
  factory :recipe do
    name { "Some recipe name" }
    portions { 1 }
    instructions { "Some long instructions for the recipe" }
    cook_minutes { 60 }
  end
end
