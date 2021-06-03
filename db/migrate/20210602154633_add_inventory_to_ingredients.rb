class AddInventoryToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :inventory, :integer, default: 0
  end
end
