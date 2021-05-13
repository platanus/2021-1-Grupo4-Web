# frozen_string_literal: true

CORNERSHOP_PRODUCT_SCHEMA = {
  type: :object,
  properties: {
    provider: {
      type: :object,
      properties: {
        id: { type: :integer, example: 1 },
        name: { type: :string, example: 'Jumbo' },
        address: { type: :string, example: 'Av. Bilbao 223' },
        country: { type: :string, example: 'CL' }
      }
    },
    products: {
      type: :array,
      items: {
        type: :object,
        properties: {
          price: { type: :float, example: 2290.0 },
          measure: { type: :string, example: 'UN' },
          package: { type: :string, example: '600 grs.' },
          name: { type: :string, example: "Kingsbury - Pan molde perfecto blanco" },
          img_url: { type: :string, example: "https://s.cornershopapp.com/img-url" }
        }
      }
    }
  }
}
