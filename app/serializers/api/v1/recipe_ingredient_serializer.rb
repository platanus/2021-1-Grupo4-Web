class Api::V1::RecipeIngredientSerializer < ActiveModel::Serializer
  type :recipe_ingredient

  attributes(
    :ingredient,
    :ingredient_quantity,
    :created_at,
    :updated_at
  )

  def ingredient
    Api::V1::IngredientSerializer.new(object.ingredient)
  end
end
