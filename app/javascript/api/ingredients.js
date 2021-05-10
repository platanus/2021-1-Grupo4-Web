<<<<<<< HEAD
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

async function editIngredient(email, token, ingredientId, ingredientInfo) {
  return (axios
    .put(`/api/v1/ingredients/${ingredientId}`, {
=======
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
>>>>>>> 888c52a7099f2d7f57fe31efdbc7c5d45422a123
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
<<<<<<< HEAD
      params: {
        'user_email': email,
        'user_token': token,
      },
=======
>>>>>>> 888c52a7099f2d7f57fe31efdbc7c5d45422a123
    }));
}

export { getIngredients, postIngredient, deleteIngredient, editIngredient };
