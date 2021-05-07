class RecipeStep < ApplicationRecord
  belongs_to :recipe

  validates :number, :description, presence: true
  validate :number_on_range, on: :update

  before_validation :set_initial_number, on: :create
  before_update :save_number_and_update_all_steps
  before_destroy :decrement_all_forward_numbers

  private

  def set_initial_number
    last_step_number = recipe.steps.maximum(:number)

    self.number = last_step_number.blank? ? 1 : last_step_number + 1
  end

  def save_number_and_update_all_steps
    return if number_was == number

    move_backwards = number_was > number
    move_backwards ? increment_step_numbers : decrement_step_numbers
  end

  # rubocop:disable Rails/SkipsModelValidations
  def increment_step_numbers
    (number..number_was - 1).reverse_each do |step|
      recipe.steps.find_by(number: step).update_column(:number, step + 1)
    end
  end

  def decrement_step_numbers
    (number_was + 1..number).each do |step|
      recipe.steps.find_by(number: step).update_column(:number, step - 1)
    end
  end

  def decrement_all_forward_numbers
    last_step_number = recipe.steps.maximum(:number)

    (number..last_step_number).each do |step|
      recipe.steps.find_by(number: step).update_column(:number, step - 1)
    end
  end
  # rubocop:enable Rails/SkipsModelValidations

  def number_on_range
    return if number.blank? || recipe.blank?

    last_number = recipe.steps.count
    errors.add(:number, "must be #{last_number} or less") if number > last_number
  end
end

# == Schema Information
#
# Table name: recipe_steps
#
#  id          :bigint(8)        not null, primary key
#  number      :integer
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
