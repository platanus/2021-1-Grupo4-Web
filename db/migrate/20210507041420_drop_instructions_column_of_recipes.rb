class DropInstructionsColumnOfRecipes < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :recipes, :instructions, :text }
  end
end
