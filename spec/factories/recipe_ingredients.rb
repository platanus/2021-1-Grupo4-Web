FactoryBot.define do
  factory :recipe_ingredient do
    ingredient_quantity { rand(1..4) }
  end
end
