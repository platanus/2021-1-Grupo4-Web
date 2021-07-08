class ChangeMeasureQuantityToFloat < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      change_column :ingredient_measures, :quantity, :float
    end
  end
end
