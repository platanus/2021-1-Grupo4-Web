RECIPE_STEP_SCHEMA = {
  type: :object,
  properties: {
    description: { type: :string, example: 'Prender el horno', 'x-nullable': true }
  }
}

RECIPE_STEP_UPDATE_SCHEMA = {
  type: :object,
  properties: {
    number: { type: :integer, example: 2, 'x-nullable': false },
    description: { type: :string, example: 'Prender el horno', 'x-nullable': true }
  }
}

RECIPE_STEP_RESPONSE_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'recipe_step' },
    attributes: {
      type: :object,
      properties: {
        number: { type: :integer, example: 1, 'x-nullable': true },
        description: { type: :string, example: 'Prender el horno', 'x-nullable': true },
        media_url: { type: :string, example: 'https://some-media-url.com', 'x-nullable': true },
        recipe_id: { type: :integer, example: 1, 'x-nullable': true },
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

RECIPE_STEPS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/recipe_step_response" }
    }
  },
  required: [
    :data
  ]
}

RECIPE_STEP_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/recipe_step_response" }
  },
  required: [
    :data
  ]
}
