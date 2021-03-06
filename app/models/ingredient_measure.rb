class IngredientMeasure < ApplicationRecord
  include PowerTypes::Observable
  belongs_to :ingredient

  validates :quantity, presence: true
end

# == Schema Information
#
# Table name: ingredient_measures
#
#  id            :bigint(8)        not null, primary key
#  quantity      :float
#  ingredient_id :bigint(8)        not null
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  primary       :boolean          default(FALSE)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#
