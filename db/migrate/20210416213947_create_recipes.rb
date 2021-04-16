class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
    	t.integer :user_id
    	t.integer :menu_id
      t.string :name
      t.integer :portions
      t.text :instructions
      t.integer :cook_minutes

      t.timestamps
    end
  end
end
