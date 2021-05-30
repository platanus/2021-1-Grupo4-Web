class Ingredient < ApplicationRecord
  belongs_to :user
  belongs_to :provider, optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients, dependent: nil
  has_many :ingredient_measures, dependent: :destroy
  accepts_nested_attributes_for :ingredient_measures

  validates :inventory, numericality: { greater_than_or_equal_to: 0 }

  def decrement_inventory!(quantity_to_decrement)
    final_inventory = [inventory - quantity_to_decrement, 0].max
    update!(inventory: final_inventory)
  end

  def measure
    default_measure&.name
  end

  def quantity
    default_measure&.quantity
  end

  def default_measure
    ingredient_measures.first
  end
end

# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint(8)        not null, primary key
#  provider_id :bigint(8)
#  user_id     :bigint(8)        not null
#  name        :string
#  sku         :string
#  price       :integer
#  currency    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  inventory   :integer          default(0)
#
# Indexes
#
#  index_ingredients_on_provider_id  (provider_id)
#  index_ingredients_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (provider_id => providers.id)
#  fk_rails_...  (user_id => users.id)
#
