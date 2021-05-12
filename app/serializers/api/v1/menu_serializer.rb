class Api::V1::MenuSerializer < ActiveModel::Serializer
  type :menu

  attributes(
    :name,
    :recipes_menu,
    :created_at,
    :updated_at
  )
end
