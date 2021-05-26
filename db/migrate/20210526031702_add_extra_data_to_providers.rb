class AddExtraDataToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :email, :string
    add_column :providers, :webpage_url, :string
    add_column :providers, :delivery_days, :integer
    add_column :providers, :minimum_purchase, :integer
    add_column :providers, :phone, :string
  end
end
