class AddAdditionalDataToProvider < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :contact_name, :string
    add_column :providers, :contact_rut, :string
    add_column :providers, :bank_name, :string
    add_column :providers, :account_type, :string
    add_column :providers, :account_number, :string
  end
end
