import client from '../auth/authClient.js';

async function getIngredients() {
  return (client
    .get('/ingredients', {
    }));
}

async function postIngredient(ingredient) {
  return (client
    .post('/ingredients',
      { ingredient },
    ));
}

async function deleteIngredient(ingredientId) {
  return (client
    .delete(`/ingredients/${ingredientId}`, {
    }));
}

async function editIngredient(ingredientId, ingredientInfo) {
  return (client
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
