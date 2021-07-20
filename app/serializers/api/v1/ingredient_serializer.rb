class Api::V1::IngredientSerializer < ActiveModel::Serializer
  type :ingredient

  attributes(
    :id,
    :provider_name,
    :user_id,
    :name,
    :sku,
    :price,
    :currency,
    :quantity,
    :measure,
    :inventory,
    :minimum_quantity,
    :other_measures,
    :created_at,
    :updated_at
  )

  def other_measures
    ActiveModelSerializers::SerializableResource.new(
      object.ingredient_measures.order(primary: :desc),
      each_serializer: Api::V1::IngredientMeasureSerializer
    )
  end

  def provider_name
    object.provider&.name
  end
end
