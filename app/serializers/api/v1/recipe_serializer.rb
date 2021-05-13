class Api::V1::RecipeSerializer < ActiveModel::Serializer
  type :recipe

  attributes(
    :user_id,
    :name,
    :portions,
    :cook_minutes,
    :created_at,
    :updated_at,
    :ingredients,
    :steps
  )

  def steps
    ActiveModelSerializers::SerializableResource.new(object.steps.rank(:step_order),
                                                     each_serializer: Api::V1::RecipeStepSerializer)
  end
end
