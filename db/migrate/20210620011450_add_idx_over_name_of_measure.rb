class AddIdxOverNameOfMeasure < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :ingredient_measures, [:name, :ingredient_id], unique: true, algorithm: :concurrently
  end
end
