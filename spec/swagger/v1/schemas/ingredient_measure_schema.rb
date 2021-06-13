# frozen_string_literal: true

INGREDIENT_MEASURE_SCHEMA = {
  type: :object,
  properties: {
    name: { type: :string, example: 'unidad' },
    quantity: { type: :integer, example: 2 }
  }
}
