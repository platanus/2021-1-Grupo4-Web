// eslint-disable-next-line import/prefer-default-export
export function getPriceOfSelectedIngredient(recipeIngredient) {
  if (!recipeIngredient.ingredientQuantity) return 0;

  return recipeIngredient.ingredientQuantity * recipeIngredient.ingredient.price / recipeIngredient.ingredient.quantity;
}
