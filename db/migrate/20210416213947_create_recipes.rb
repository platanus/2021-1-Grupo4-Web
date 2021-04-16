class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :portions
      t.text :instructions
      t.integer :cook_minutes

      t.timestamps
    end
  end
end
