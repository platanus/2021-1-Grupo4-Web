import axios from '../auth/authClient.js';

async function getIngredients() {
  return (axios
    .get('/ingredients', {
    }));
}

async function postIngredient(ingredient) {
  return (axios
    .post('/ingredients',
      { ingredient },
    ));
}

async function deleteIngredient(ingredientId) {
  return (axios
    .delete(`/ingredients/${ingredientId}`, {
    }));
}

async function editIngredient(ingredientId, ingredientInfo) {
  return (axios
    .put(`/ingredients/${ingredientId}`, {
      ingredient: {
        'provider_id': ingredientInfo.providerId,
        'name': ingredientInfo.name,
        'sku': ingredientInfo.sku,
        'price': ingredientInfo.price,
        'currency': ingredientInfo.currency,
        'quantity': ingredientInfo.quantity,
        'measure': ingredientInfo.measure,
      },
    }, {
    }));
}

export { getIngredients, postIngredient, deleteIngredient, editIngredient };
