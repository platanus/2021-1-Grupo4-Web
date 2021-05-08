import axios from 'axios';

async function getIngredients(email, token) {
  return (axios
    .get('/api/v1/ingredients', {
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

async function postIngredient(ingredient, email, token) {
  return (axios
    .post('/api/v1/ingredients',
      { ingredient },
      { params: {
        'user_email': email,
        'user_token': token,
      } }));
}

async function deleteIngredient(email, token, ingredientId) {
  return (axios
    .delete(`/api/v1/ingredients/${ingredientId}`, {
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

async function editIngredient(email, token, ingredientId, ingredientInfo) {
  return (axios
    .put(`/api/v1/ingredients/${ingredientId}`, {
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
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

export { getIngredients, postIngredient, deleteIngredient, editIngredient };
