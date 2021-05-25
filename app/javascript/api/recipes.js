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

export { getRecipes, getRecipe, deleteRecipe };
