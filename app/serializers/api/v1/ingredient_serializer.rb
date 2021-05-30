class Api::V1::IngredientSerializer < ActiveModel::Serializer
  type :ingredient

  attributes(
    :provider_id,
    :user_id,
    :name,
    :sku,
    :price,
    :currency,
    :quantity,
    :measure,
    :inventory,
    :other_measures,
    :created_at,
    :updated_at
  )

  def other_measures
    ActiveModelSerializers::SerializableResource.new(
      object.ingredient_measures, each_serializer: Api::V1::IngredientMeasureSerializer
    )
  end
end
