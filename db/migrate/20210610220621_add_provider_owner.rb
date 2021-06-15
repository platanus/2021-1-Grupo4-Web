class AddProviderOwner < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      add_reference :providers, :user, foreign_key: true
    end
  end
end
