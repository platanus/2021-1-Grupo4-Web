MENU_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Menú de almuerzo', 'x-nullable': true },
    portions: { type: :integer, example: 5, 'x-nullable': false },
    menu_recipes_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          recipe_id: { type: :integer, example: 1, 'x-nullable': false },
          recipe_quantity: { type: :integer, example: 5, 'x-nullable': true }
        }
      }
    }
  },
  required: [
    :name
  ]
}

MENU_UPDATE_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Menú de almuerzo', 'x-nullable': true },
    portions: { type: :integer, example: 5, 'x-nullable': false },
    menu_recipes_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          id: { type: :integer, example: 1, 'x-nullable': true },
          recipe_id: { type: :integer, example: 1, 'x-nullable': false },
          recipe_quantity: { type: :integer, example: 5, 'x-nullable': true },
          _destroy: { type: :boolean, example: false, 'x-nullable': true }
        }
      }
    }
  },
  required: [
    :name
  ]
}

MENU_RESPONSE_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'menu' },
    attributes: {
      type: :object,
      properties: {
        name: { type: :string, example: 'Menú de almuerzo', 'x-nullable': true },
        created_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        updated_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        menu_recipes: {
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/menu_recipe_response" }
            }
          }
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

MENUS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/menu_response" }
    }
  },
  required: [
    :data
  ]
}

MENU_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/menu_response" }
  },
  required: [
    :data
  ]
}
