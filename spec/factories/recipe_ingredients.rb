FactoryBot.define do
  factory :recipe_ingredient do
    recipe_id { 1 }
    ingredient_id { 1 }
    quantity { 1 }
  end
end
