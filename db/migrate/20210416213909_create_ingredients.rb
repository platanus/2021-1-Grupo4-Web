class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :provider, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :sku
      t.integer :price
      t.string :currency
      t.integer :quantity
      t.string :measure

      t.timestamps
    end
  end
end
