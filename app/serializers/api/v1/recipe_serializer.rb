class Api::V1::RecipeSerializer < ActiveModel::Serializer
  type :recipe

  attributes(
    :user_id,
    :name,
    :portions,
    :cook_minutes,
    :created_at,
    :updated_at,
    :ingredients
    :steps
  )

  def steps
    object.steps.order(:number)
  end
end
