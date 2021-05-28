class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_recipes, dependent: :destroy
  has_many :recipes, through: :menu_recipes, dependent: nil
  accepts_nested_attributes_for :menu_recipes
end

# == Schema Information
#
# Table name: menus
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_menus_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
