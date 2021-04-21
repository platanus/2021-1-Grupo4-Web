class Ingredient < ApplicationRecord
  belongs_to :user
  belongs_to :provider
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients, dependent: nil
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
#  quantity    :integer
#  measure     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
