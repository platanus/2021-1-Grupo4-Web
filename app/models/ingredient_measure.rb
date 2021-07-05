class IngredientMeasure < ApplicationRecord
  belongs_to :ingredient

  validates :name, presence: true, uniqueness: { scope: :ingredient_id }
  validates :quantity, presence: true

  before_save { name.capitalize! }
end

# == Schema Information
#
# Table name: ingredient_measures
#
#  id            :bigint(8)        not null, primary key
#  quantity      :integer
#  ingredient_id :bigint(8)        not null
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  primary       :boolean          default(FALSE)
#
# Indexes
#
#  index_ingredient_measures_on_ingredient_id           (ingredient_id)
#  index_ingredient_measures_on_name_and_ingredient_id  (name,ingredient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#
