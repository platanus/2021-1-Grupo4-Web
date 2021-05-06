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

async function postIngredient(newIngredient, email, token) {
  return (axios
    .post('/api/v1/ingredients', {
      ingredient: {
        'provider_id': newIngredient.providerId,
        'name': newIngredient.name,
        'sku': newIngredient.sku,
        'price': newIngredient.price,
        'currency': newIngredient.currency,
        'quantity': newIngredient.quantity,
        'measure': newIngredient.measure,
      },
    }, { params: {
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

export { getIngredients, postIngredient, deleteIngredient };
