RECIPE_INGREDIENT_SCHEMA = {
  type: :object,
  properties: {
    ingredient_id: { type: :integer, example: 1, 'x-nullable': false },
    ingredient_quantity: { type: :integer, example: 3, 'x-nullable': true },
    ingredient_measure: { type: :string, example: 'Kilo', 'x-nullable': true }
  }
}

RECIPE_INGREDIENT_RESPONSE = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'recipe_ingredient' },
    attributes: {
      type: :object,
      properties: {
        recipe_id: { type: :integer, example: 1, 'x-nullable': false },
        ingredient: { "$ref" => "#/definitions/ingredient_response" },
        ingredient_quantity: { type: :integer, example: 3, 'x-nullable': true },
        ingredient_measure: { type: :string, example: 'Kilo', 'x-nullable': true },
        created_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        updated_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true }
      },
      required: []
    }
  },
  required: [
    :id,
    :type,
    :attributes
  ]
}

RECIPE_INGREDIENTS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/recipe_ingredient" }
    }
  },
  required: [
    :data
  ]
}

RECIPE_INGREDIENT_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/recipe_ingredient" }
  },
  required: [
    :data
  ]
}
