class AddPrimaryToIngredientMeasure < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredient_measures, :primary, :boolean, default: false
  end
end
