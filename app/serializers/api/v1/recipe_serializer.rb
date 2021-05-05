class Api::V1::RecipeSerializer < ActiveModel::Serializer
  type :recipe

  attributes(
    :user_id,
    :name,
    :portions,
    :instructions,
    :cook_minutes,
    :created_at,
    :updated_at
  )
end
