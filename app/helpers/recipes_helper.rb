# == Schema Information
#
# Table name: recipes
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  menu_id      :integer
#  name         :string
#  portions     :integer
#  instructions :text
#  cook_minutes :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module RecipesHelper
end
