RECIPE_INGREDIENT_SCHEMA = {
  type: :object,
  properties: {
    ingredient_id: { type: :integer, example: 1, 'x-nullable': true },
    ingredient_quantity: { type: :integer, example: 4, 'x-nullable': true }
  },
  required: [
    :ingredient_id,
    :ingredient_quantity
  ]
}
