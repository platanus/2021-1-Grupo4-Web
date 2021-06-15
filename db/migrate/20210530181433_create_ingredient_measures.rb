class CreateIngredientMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredient_measures do |t|
      t.integer :quantity
      t.references :ingredient, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
