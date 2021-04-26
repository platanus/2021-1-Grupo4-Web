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
    :created_at,
    :updated_at
  )
end
