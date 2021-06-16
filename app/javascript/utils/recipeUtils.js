
function isInt(n) {
  return n % 1 === 0;
}

function unitaryPrice(recipeIngredient) {
  const defaultQuantity = recipeIngredient.ingredient.otherMeasures.data.map(element =>
    element.attributes).filter(element =>
    element.name === recipeIngredient.ingredientMeasure)[0].quantity;
  const price = recipeIngredient.ingredient.price / defaultQuantity;
  if (isInt(price)) {
    return price;
  }

  return Math.round(recipeIngredient.ingredient.price / defaultQuantity);
}

// eslint-disable-next-line import/prefer-default-export
export function getPriceOfSelectedIngredient(recipeIngredient) {
  if (!recipeIngredient.ingredientQuantity) return 0;

  return recipeIngredient.ingredientQuantity * unitaryPrice(recipeIngredient);
}
