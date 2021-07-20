class RemoveDuplicatedMeasureIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :ingredient_measures, name: "index_ingredient_measures_on_ingredient_id"
    remove_index :ingredient_measures, name: "index_ingredient_measures_on_name_and_ingredient_id"
  end
end
