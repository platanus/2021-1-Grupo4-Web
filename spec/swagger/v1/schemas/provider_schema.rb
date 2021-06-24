PROVIDER_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'Jumbo', 'x-nullable': true },
    address: { type: :string, example: 'Av. Francisco Bilbao 223', 'x-nullable': true },
    email: { type: :string, example: 'jumbo@uc.cl', 'x-nullable': true },
    phone: { type: :string, example: '+56 2 99222122', 'x-nullable': true },
    country: { type: :string, example: 'Chile', 'x-nullable': true },
    webpage_url: { type: :string, example: 'https://jumbo.cl', 'x-nullable': true },
    contact_name: { type: :string, example: 'Marisol Pérez', 'x-nullable': true },
    contact_rut: { type: :string, example: '11.353.222-3', 'x-nullable': true },
    bank_name: { type: :string, example: 'Banchile', 'x-nullable': true },
    account_type: { type: :string, example: 'Cuenta Corriente', 'x-nullable': true },
    account_number: { type: :string, example: '0-00-11233322', 'x-nullable': true },
    delivery_days: { type: :integer, example: 1, 'x-nullable': true },
    minimum_purchase: { type: :integer, example: 15_000, 'x-nullable': true }
  },
  required: [
    :name
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
        name: { type: :string, example: 'Jumbo', 'x-nullable': true },
        address: { type: :string, example: 'Av. Francisco Bilbao 223', 'x-nullable': true },
        email: { type: :string, example: 'jumbo@uc.cl', 'x-nullable': true },
        phone: { type: :string, example: '+56 2 99222122', 'x-nullable': true },
        country: { type: :string, example: 'Chile', 'x-nullable': true },
        webpage_url: { type: :string, example: 'https://jumbo.cl', 'x-nullable': true },
        contact_name: { type: :string, example: 'Marisol Pérez', 'x-nullable': true },
        contact_rut: { type: :string, example: '11.353.222-3', 'x-nullable': true },
        bank_name: { type: :string, example: 'Banchile', 'x-nullable': true },
        account_type: { type: :string, example: 'Cuenta Corriente', 'x-nullable': true },
        account_number: { type: :string, example: '0-00-11233322', 'x-nullable': true },
        delivery_days: { type: :integer, example: 1, 'x-nullable': true },
        minimum_purchase: { type: :integer, example: 15_000, 'x-nullable': true },
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
