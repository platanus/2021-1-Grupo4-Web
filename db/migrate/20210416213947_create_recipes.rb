class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
<<<<<<< HEAD
    	t.references :user,  null: false, foreign_key: true
=======
>>>>>>> ce2d487 (feat(crud): create models Recipe RecipeIngredients Menu)
      t.string :name
      t.integer :portions
      t.text :instructions
      t.integer :cook_minutes

      t.timestamps
    end
  end
end
