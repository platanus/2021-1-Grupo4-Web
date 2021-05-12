class Api::V1::RecipeSerializer < ActiveModel::Serializer
  type :recipe

  attributes(
    :user_id,
    :name,
    :portions,
    :instructions,
    :cook_minutes,
    :created_at,
    :updated_at,
    :recipe_ingredients
  )

  def recipe_ingredients
    ActiveModelSerializers::SerializableResource.new(
      object.recipe_ingredients, each_serializer: Api::V1::RecipeIngredientSerializer
    )
  end
end
