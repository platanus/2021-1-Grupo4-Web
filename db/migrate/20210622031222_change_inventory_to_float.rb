class ChangeInventoryToFloat < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      change_column :ingredients, :inventory, :float
    end
  end
end
