class Api::V1::MenuSerializer < ActiveModel::Serializer
  type :menu

  attributes(
    :name,
    :menu_recipes,
    :portions,
    :created_at,
    :updated_at
  )

  def menu_recipes
    ActiveModelSerializers::SerializableResource.new(
      object.menu_recipes, each_serializer: Api::V1::MenuRecipeSerializer
    )
  end
end
