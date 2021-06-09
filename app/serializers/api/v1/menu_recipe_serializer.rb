class Api::V1::MenuRecipeSerializer < ActiveModel::Serializer
  type :menu_recipe

  attributes(
    :recipe_quantity,
    :recipe,
    :created_at,
    :updated_at
  )

  def recipe
    Api::V1::RecipeSerializer.new(object.recipe)
  end
end
