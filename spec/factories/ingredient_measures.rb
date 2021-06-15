FactoryBot.define do
  factory :ingredient_measure do
    quantity { 1 }
    ingredient { create(:ingredient) }
    name { "L" }
  end
end
