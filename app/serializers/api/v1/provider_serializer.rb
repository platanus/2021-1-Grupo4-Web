class Api::V1::ProviderSerializer < ActiveModel::Serializer
  type :provider

  attributes(
    :name,
    :address,
    :country,
    :ingredients,
    :created_at,
    :updated_at
  )
end
