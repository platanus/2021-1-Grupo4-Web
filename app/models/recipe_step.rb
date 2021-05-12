class RecipeStep < ApplicationRecord
  include RankedModel

  belongs_to :recipe

  before_validation :set_initial_step_order, on: :create

  validates :description, presence: true
  ranks :step_order
end

def set_initial_step_order
  self.step_order_position = :last
end

# == Schema Information
#
# Table name: recipe_steps
#
#  id          :bigint(8)        not null, primary key
#  step_order  :integer
#  description :text
#  media_url   :string
#  recipe_id   :bigint(8)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipe_steps_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
