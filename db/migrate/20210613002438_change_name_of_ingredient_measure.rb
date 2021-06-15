class ChangeNameOfIngredientMeasure < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      rename_column :recipe_ingredients, :recipe_measure, :ingredient_measure
    end
  end
end
