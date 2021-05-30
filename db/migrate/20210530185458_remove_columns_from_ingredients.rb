class RemoveColumnsFromIngredients < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :ingredients, :quantity, :integer }
    safety_assured { remove_column :ingredients, :measure, :string }
  end
end
