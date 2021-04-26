MENU_SCHEMA = {
  type: :object,
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'menu' },
    attributes: {
      type: :object,
      properties: {
        user_id: { type: :integer, example: 666, 'x-nullable': true },
        name: { type: :string, example: 'Some name', 'x-nullable': true },
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

MENUS_COLLECTION_SCHEMA = {
  type: "object",
  properties: {
    data: {
      type: "array",
      items: { "$ref" => "#/definitions/menu" }
    }
  },
  required: [
    :data
  ]
}

MENU_RESOURCE_SCHEMA = {
  type: "object",
  properties: {
    data: { "$ref" => "#/definitions/menu" }
  },
  required: [
    :data
  ]
}
