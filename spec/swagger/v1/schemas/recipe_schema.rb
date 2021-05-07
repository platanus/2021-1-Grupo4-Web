RECIPE_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Pastel de choclo', 'x-nullable': true },
    portions: { type: :integer, example: 4, 'x-nullable': true },
    cook_minutes: { type: :integer, example: 25, 'x-nullable': true }
  },
  required: [
    :name,
    :portions,
    :cook_minutes
  ]
}

RECIPE_RESPONSE_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'ingredient' },
    attributes: {
      type: :object,
      properties: {
        user_id: { type: :integer, example: 1, 'x-nullable': true },
        name: { type: :string, example: 'Pastel de choclo', 'x-nullable': true },
        portions: { type: :integer, example: 4, 'x-nullable': true },
        cook_minutes: { type: :integer, example: 25, 'x-nullable': true },
        created_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        updated_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        ingredients: {
          type: "array",
          items: { "$ref" => "#/definitions/ingredient_response" }
        },
        steps: {
          type: "array",
          items: { "$ref" => "#/definitions/recipe_step_response" }
        }
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

RECIPES_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/recipe_response" }
    }
  },
  required: [
    :data
  ]
}

RECIPE_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/recipe_response" }
  },
  required: [
    :data
  ]
}
