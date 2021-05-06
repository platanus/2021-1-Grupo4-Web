import axios from 'axios';

async function getIngredients(email, token) {
  return (axios
  .get('https://pl-super-kitchen-staging.herokuapp.com/api/v1/ingredients', { 
    params: {
    'user_email': email,
    'user_token': token,
    } 
  }));
};

async function postIngredient(newIngredient, email, token) {
  return (axios
          .post('https://pl-super-kitchen-staging.herokuapp.com/api/v1/ingredients', {
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
};

async function deleteIngredient(email, token, ingredient_id) {
  return (axios
  .delete(`https://pl-super-kitchen-staging.herokuapp.com/api/v1/ingredients/${ingredient_id}`, { 
    params: {
    'user_email': email,
    'user_token': token,
    } 
  }));
};

export { getIngredients, postIngredient, deleteIngredient };