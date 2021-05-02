FactoryBot.define do
  factory :menu_recipe do
    recipe_quantity { rand(1..10) }
  end
end
