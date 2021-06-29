class AddMinimumQuantityToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :minimum_quantity, :float
  end
end
