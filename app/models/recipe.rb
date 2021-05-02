class Recipe < ApplicationRecord
  belongs_to :user
  has_many :menu_recipes, dependent: :destroy
  has_many :menus, through: :menu_recipes, dependent: nil
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients, dependent: nil
end

# == Schema Information
#
# Table name: recipes
#
#  id           :bigint(8)        not null, primary key
#  user_id      :bigint(8)        not null
#  name         :string
#  portions     :integer
#  instructions :text
#  cook_minutes :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
