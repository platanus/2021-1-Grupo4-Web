class Api::V1::ProviderSerializer < ActiveModel::Serializer
  type :provider
  attributes(:id, :name, :address, :country)
end
