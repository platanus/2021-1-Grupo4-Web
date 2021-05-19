class Api::V1::RecipeIngredientSerializer < ActiveModel::Serializer
  type :recipe_ingredient

  attributes(
    :ingredient,
    :ingredient_quantity,
    :created_at,
    :updated_at
  )
end
