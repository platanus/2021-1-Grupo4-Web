class AddProviderToIngredients < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_reference :ingredients, :provider, index: {algorithm: :concurrently}
  end
end
