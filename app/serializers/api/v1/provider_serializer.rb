class Api::V1::ProviderSerializer < ActiveModel::Serializer
    type :provider
    attributes(:name, :address, :country)
  end
  