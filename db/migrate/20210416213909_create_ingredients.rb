class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.integer :provider_id
      t.integer :user_id
      t.string :name
      t.string :SKU
      t.integer :price
      t.string :currency
      t.integer :quantity
      t.string :measure

      t.timestamps
    end
  end
end
