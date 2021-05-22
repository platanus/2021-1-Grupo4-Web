MENU_RECIPE_SCHEMA = {
  type: :object,
  properties: {
    recipe_id: { type: :integer, example: 1, 'x-nullable': false },
    recipe_quantity: { type: :integer, example: 3, 'x-nullable': true }
  }
}

MENU_RECIPE_RESPONSE = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'menu_recipe' },
    attributes: {
      type: :object,
      properties: {
        menu_id: { type: :integer, example: 1, 'x-nullable': false },
        recipe: { "$ref" => "#/definitions/recipe_response" },
        recipe_quantity: { type: :integer, example: 3, 'x-nullable': true },
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

MENU_RECIPES_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/menu_recipe" }
    }
  },
  required: [
    :data
  ]
}

MENU_RECIPE_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/menu_recipe" }
  },
  required: [
    :data
  ]
}
