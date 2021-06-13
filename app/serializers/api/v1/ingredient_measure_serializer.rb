class Api::V1::IngredientMeasureSerializer < ActiveModel::Serializer
  type :ingredient_measure

  attributes(
    :name,
    :quantity
  )
end
