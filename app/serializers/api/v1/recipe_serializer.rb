class Api::V1::RecipeSerializer < ActiveModel::Serializer
  type :recipe

  attributes(
    :name,
    :portions,
    :instructions,
    :cook_minutes,
    :ingredients_quantity,
    :created_at,
    :updated_at
  )
end
