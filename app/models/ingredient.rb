class Ingredient < ApplicationRecord
  belongs_to :user
  belongs_to :provider
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
end

# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint(8)        not null, primary key
#  provider_id :integer
#  user_id     :integer
#  name        :string
#  SKU         :string
#  price       :integer
#  currency    :string
#  quantity    :integer
#  measure     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
