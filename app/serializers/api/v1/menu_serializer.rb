class Api::V1::MenuSerializer < ActiveModel::Serializer
  type :menu

  attributes(
    :user_id,
    :name,
    :created_at,
    :updated_at
  )
end
