class Api::V1::RecipeStepSerializer < ActiveModel::Serializer
  type :recipe_step

  attributes(
    :number,
    :description,
    :media_url,
    :recipe_id,
    :created_at,
    :updated_at
  )
end
