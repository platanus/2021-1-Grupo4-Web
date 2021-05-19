import client from '../auth/authClient.js';

function getIngredients() {
  return (client
    .get('/ingredients', {
    }));
}

function postIngredient(ingredient) {
  return (client
    .post('/ingredients',
      { ingredient },
    ));
}

function deleteIngredient(ingredientId) {
  return (client
    .delete(`/ingredients/${ingredientId}`, {
    }));
}

function editIngredient(ingredientId, ingredientInfo) {
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

async function searchCornershopIngredients(query) {
  return (client
    .get('/search-cornershop-products', {
      params: {
        query,
      },
    },
    )
  );
}

export { getIngredients, postIngredient, deleteIngredient, editIngredient, searchCornershopIngredients };
