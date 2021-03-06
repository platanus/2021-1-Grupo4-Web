class Api::V1::RecipeStepSerializer < ActiveModel::Serializer
  type :recipe_step

  attributes(
    :step_order_rank,
    :description,
    :media_url,
    :recipe_id,
    :created_at,
    :updated_at
  )
end
