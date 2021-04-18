class Api::V1::UserSerializer < ActiveModel::Serializer
  type :user
  attributes(:id, :email, :authentication_token)
end
