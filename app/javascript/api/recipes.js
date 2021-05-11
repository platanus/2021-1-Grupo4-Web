import client from '../auth/authClient.js';

async function getRecipes() {
  return (client
    .get('/recipes', {
    }));
}

async function getRecipe(recipeId) {
  return (client
    .get(`/recipes/${recipeId}`, {
    }));
}

async function deleteRecipe(recipeId) {
  return (client
    .delete(`/recipes/${recipeId}`, {
    }));
}

export { getRecipes, getRecipe, deleteRecipe };
