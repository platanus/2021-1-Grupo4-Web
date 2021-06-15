class ChangeIngredientsQuantityToFloat < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      change_column :recipe_ingredients, :ingredient_quantity, :float
    end
  end
end
