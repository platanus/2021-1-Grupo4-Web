# frozen_string_literal: true

PROVIDER_INGREDIENT_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string },
    price: { type: :string },
    measure: { type: :string },
    provider: { type: :string }
  }
}
