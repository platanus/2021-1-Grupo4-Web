class AddIngredientMeasureToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipe_ingredients, :recipe_measure, :string
  end
end
