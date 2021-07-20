import client from '../auth/authClient.js';

function getIngredient(ingredientId) {
  return (client
    .get(`/ingredients/${ingredientId}`, {
    }));
}

function getIngredients() {
  return (client
    .get('/ingredients', {
    }));
}

function getAlertedIngredients() {
  return (client
    .get('/alert-ingredients', {
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

function editIngredient(ingredientId, ingredient) {
  return (client
    .put(`/ingredients/${ingredientId}`,
      { ingredient },
    ));
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
function getCriticalAssociations(ingredientId) {
  return (client
    .get(`/ingredients/${ingredientId}/critical-associations`, {
    }));
}

export {
  getIngredient,
  getIngredients,
  postIngredient,
  deleteIngredient,
  editIngredient,
  searchCornershopIngredients,
  getCriticalAssociations,
  getAlertedIngredients,
};
