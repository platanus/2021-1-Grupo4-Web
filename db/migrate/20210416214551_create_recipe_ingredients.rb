class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
<<<<<<< HEAD
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :ingredient_quantity
=======
      t.integer :recipe_id
      t.integer :ingredient_id
      t.integer :quantity
>>>>>>> ce2d487 (feat(crud): create models Recipe RecipeIngredients Menu)

      t.timestamps
    end
  end
end
