class Api::V1::MenuRecipeSerializer < ActiveModel::Serializer
  type :menu_recipe

  attributes(
    :recipe,
    :recipe_quantity,
    :created_at,
    :updated_at
  )
end
