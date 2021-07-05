class IngredientMeasure < ApplicationRecord
  belongs_to :ingredient

  validates :name, presence: true, uniqueness: { scope: :ingredient_id }
  validates :quantity, presence: true

  before_save do
    name.capitalize!
    update_recipe_ingredient_if_exists
  end

  before_destroy { change_recipe_ingredient_if_exists }

  def update_recipe_ingredient_if_exists
    ingredient.recipe_ingredients.each do |recipe_ingredient|
      next unless recipe_ingredient.ingredient_measure == name_was

      recipe_ingredient.update!(ingredient_measure: name)
    end
  end

  def change_recipe_ingredient_if_exists
    ingredient.recipe_ingredients.each do |recipe_ingredient|
      next unless recipe_ingredient.ingredient_measure == name_was

      replacing_measure = ingredient.default_measure
      name = replacing_measure.name
      quantity = recipe_ingredient.ingredient_quantity / quantity_was * replacing_measure.quantity
      recipe_ingredient.update!(ingredient_measure: name, ingredient_quantity: quantity)
    end
  end
end

# == Schema Information
#
# Table name: ingredient_measures
#
#  id            :bigint(8)        not null, primary key
#  quantity      :float
#  ingredient_id :bigint(8)        not null
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  primary       :boolean          default(FALSE)
#
# Indexes
#
#  index_ingredient_measures_on_ingredient_id           (ingredient_id)
#  index_ingredient_measures_on_name_and_ingredient_id  (name,ingredient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#
