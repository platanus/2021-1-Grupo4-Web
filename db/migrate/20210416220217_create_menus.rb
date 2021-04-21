class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
<<<<<<< HEAD
    	t.references :user, null: false, foreign_key: true
=======
>>>>>>> ce2d487 (feat(crud): create models Recipe RecipeIngredients Menu)
      t.string :name

      t.timestamps
    end
  end
end
