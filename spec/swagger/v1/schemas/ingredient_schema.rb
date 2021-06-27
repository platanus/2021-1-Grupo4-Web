INGREDIENT_SCHEMA = {
  type: :object,
  properties: {
    provider_name: { type: :string, example: 'Jumbo', 'x-nullable': true },
    name: { type: :string, example: 'Harina', 'x-nullable': true },
    sku: { type: :string, example: 'SK28CD2', 'x-nullable': true },
    price: { type: :integer, example: 2990, 'x-nullable': true },
    currency: { type: :string, example: 'CLP', 'x-nullable': true },
    inventory: { type: :float, example: 10.3, 'x-nullable': true },
    ingredient_measures_attributes: {
      type: "array",
      items: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Kg', 'x-nullable': false },
          quantity: { type: :integer, example: 1, 'x-nullable': true }
        }
      }
    }
  },
  required: [
    :name,
    :price,
    :currency,
    :quantity,
    :measure
  ]
}

INGREDIENT_RESPONSE_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'ingredient' },
    attributes: {
      type: :object,
      properties: {
        provider_name: { type: :string, example: 'Jumbo', 'x-nullable': true },
        user_id: { type: :integer, example: 1, 'x-nullable': true },
        name: { type: :string, example: 'Harina', 'x-nullable': true },
        sku: { type: :string, example: 'SK28CD2', 'x-nullable': true },
        price: { type: :integer, example: 2990, 'x-nullable': true },
        currency: { type: :string, example: 'CLP', 'x-nullable': true },
        quantity: { type: :integer, example: 2, 'x-nullable': true },
        measure: { type: :string, example: 'unidad', 'x-nullable': true },
        inventory: { type: :float, example: 10.3, 'x-nullable': true },
        measures: {
          type: "object",
          properties: {
            data: {
              type: "array",
              items: { "$ref" => "#/definitions/ingredient_measure_response" }
            }
          }
        },
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

INGREDIENTS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/ingredient_response" }
    }
  },
  required: [
    :data
  ]
}

INGREDIENT_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/ingredient_response" }
  },
  required: [
    :data
  ]
}

UPDATE_INVENTORY_INGREDIENTS_SCHEMA = {
  type: "array",
  items: {
    type: :object,
    properties: {
      ingredient_id: { type: :integer, example: 5 },
      inventory: { type: :float, example: 2.8 }
    }
  }
}

INGREDIENT_CRITICAL_ASSOCIATIONS = {
  type: "object",
  properties: {
    recipes: {
      type: :array,
      items: {
        type: :object,
        properties: {
          id: { type: :integer, example: 1 },
          name: { type: :string, example: 'Pastel de choclo' },
          portions: { type: :integer, example: 4 },
          cook_minutes: { type: :integer, example: 25 }
        }
      }
    }
  }
}
