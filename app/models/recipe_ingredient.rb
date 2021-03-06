class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :ingredient_quantity, :ingredient_measure, presence: true
  validates :ingredient_quantity, numericality: { greater_than_or_equal_to: 0 }
end

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id                  :bigint(8)        not null, primary key
#  recipe_id           :bigint(8)        not null
#  ingredient_id       :bigint(8)        not null
#  ingredient_quantity :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ingredient_measure  :string
#
# Indexes
#
#  index_recipe_ingredients_on_ingredient_id  (ingredient_id)
#  index_recipe_ingredients_on_recipe_id      (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
