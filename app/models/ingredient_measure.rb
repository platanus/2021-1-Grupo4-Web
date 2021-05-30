class IngredientMeasure < ApplicationRecord
  belongs_to :ingredient
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
#
# Indexes
#
#  index_ingredient_measures_on_ingredient_id  (ingredient_id)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#
