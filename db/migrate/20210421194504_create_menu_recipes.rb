class CreateMenuRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_recipes do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :recipe_quantity

      t.timestamps
    end
  end
end
