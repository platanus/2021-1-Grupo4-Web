class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe
end

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id                  :bigint(8)        not null, primary key
#  recipe_id           :integer
#  ingredient_id       :integer
#  ingredient_quantity :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
