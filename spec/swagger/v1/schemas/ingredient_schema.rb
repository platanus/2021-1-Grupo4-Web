INGREDIENT_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'ingredient' },
    attributes: {
      type: :object,
      properties: {
        provider_id: { type: :integer, example: 666, 'x-nullable': true },
        user_id: { type: :integer, example: 666, 'x-nullable': true },
        name: { type: :string, example: 'Some name', 'x-nullable': true },
        sku: { type: :string, example: 'Some sku', 'x-nullable': true },
        price: { type: :integer, example: 666, 'x-nullable': true },
        currency: { type: :string, example: 'Some currency', 'x-nullable': true },
        quantity: { type: :integer, example: 666, 'x-nullable': true },
        measure: { type: :string, example: 'Some measure', 'x-nullable': true },
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
      items: { "$ref" => "#/definitions/ingredient" }
    }
  },
  required: [
    :data
  ]
}

INGREDIENT_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/ingredient" }
  },
  required: [
    :data
  ]
}
