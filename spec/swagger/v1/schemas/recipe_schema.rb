RECIPE_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Pastel de choclo', 'x-nullable': true },
    portions: { type: :integer, example: 4, 'x-nullable': true },
    cook_minutes: { type: :integer, example: 25, 'x-nullable': true },
    recipe_ingredients_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          ingredient_id: { type: :integer, example: 2, 'x-nullable': false },
          ingredient_quantity: { type: :integer, example: 5, 'x-nullable': false }
        }
      }
    },
    steps_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          description: { type: :string, example: 'Horneamos la masa', 'x-nullable': false },
          media_url: { type: :string, example: 'https://media-url', 'x-nullable': true }
        }
      }
    }
  },
  required: [
    :name,
    :portions,
    :cook_minutes
  ]
}

RECIPE_UPDATE_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Pastel de choclo', 'x-nullable': true },
    portions: { type: :integer, example: 4, 'x-nullable': true },
    cook_minutes: { type: :integer, example: 25, 'x-nullable': true },
    recipe_ingredients_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          id: { type: :integer, example: 1, 'x-nullable': true },
          ingredient_id: { type: :integer, example: 2, 'x-nullable': false },
          ingredient_quantity: { type: :integer, example: 5, 'x-nullable': false },
          _destroy: { type: :boolean, example: false, 'x-nullable': true }
        }
      }
    },
    steps_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          id: { type: :integer, example: 1, 'x-nullable': true },
          step_order_position: { type: :integer, example: 1, 'x-nullable': true },
          description: { type: :string, example: 'Horneamos la masa', 'x-nullable': false },
          media_url: { type: :string, example: 'https://media-url', 'x-nullable': true },
          _destroy: { type: :boolean, example: false, 'x-nullable': true }
        }
      }
    }
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
    type: { type: :string, example: 'recipe' },
    attributes: {
      type: :object,
      properties: {
        user_id: { type: :integer, example: 1, 'x-nullable': true },
        name: { type: :string, example: 'Pastel de choclo', 'x-nullable': true },
        portions: { type: :integer, example: 4, 'x-nullable': true },
        cook_minutes: { type: :integer, example: 25, 'x-nullable': true },
        created_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        updated_at: { type: :string, example: '1984-06-04 09:00', 'x-nullable': true },
        recipe_ingredients: {
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/recipe_ingredient_response" }
            }
          }
        },
        steps: {
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/recipe_step_response" }
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
