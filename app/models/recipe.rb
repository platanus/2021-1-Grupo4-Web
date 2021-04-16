class Recipe < ApplicationRecord
	belongs_to :user
	belongs_to :menu
	has_many :recipe_ingridients
	has_many :ingredients, throug: :recipe_ingridients
end

# == Schema Information
#
# Table name: recipes
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  portions     :integer
#  instructions :text
#  cook_minutes :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
