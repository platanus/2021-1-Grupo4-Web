class MenuRecipe < ApplicationRecord
    belongs_to :recipe
    belongs_to :menu
end

# == Schema Information
#
# Table name: menu_recipes
#
#  id         :bigint(8)        not null, primary key
#  menu_id    :bigint(8)        not null
#  recipe_id  :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_menu_recipes_on_menu_id    (menu_id)
#  index_menu_recipes_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (menu_id => menus.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
