import client from '../auth/authClient.js';

function getRecipes() {
  return (client
    .get('/recipes', {
    }));
}

function getRecipe(recipeId) {
  return (client
    .get(`/recipes/${recipeId}`, {
    }));
}

function deleteRecipe(recipeId) {
  return (client
    .delete(`/recipes/${recipeId}`, {
    }));
}

function postRecipe(recipe) {
  return (client
    .post('/recipes',
      { recipe },
    ));
}

export { getRecipes, getRecipe, deleteRecipe, postRecipe };
