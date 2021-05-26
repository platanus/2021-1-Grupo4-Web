class Api::V1::ProviderSerializer < ActiveModel::Serializer
  type :provider

  attributes(
    :name,
    :email,
    :phone,
    :address,
    :country,
    :minimum_purchase,
    :webpage_url,
    :delivery_days,
    :ingredients,
    :created_at,
    :updated_at
  )
end
