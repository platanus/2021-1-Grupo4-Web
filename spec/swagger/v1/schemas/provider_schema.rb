PROVIDER_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Some name', 'x-nullable': true },
    address: { type: :string, example: 'Some address', 'x-nullable': true },
    country: { type: :string, example: 'Some country', 'x-nullable': true }
  },
  required: [
    :name,
    :address,
    :country
  ]
}

PROVIDER_RESPONSE_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'provider' },
    attributes: {
      type: :object,
      properties: {
        name: { type: :string, example: 'Some name', 'x-nullable': true },
        address: { type: :string, example: 'Some address', 'x-nullable': true },
        country: { type: :string, example: 'Some country', 'x-nullable': true },
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

PROVIDERS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/provider_response" }
    }
  },
  required: [
    :data
  ]
}

PROVIDER_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/provider_response" }
  },
  required: [
    :data
  ]
}
