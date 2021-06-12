class AddNameIndexToProviders < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      add_index :providers, [:name, :user_id], unique: true
    end
  end
end
