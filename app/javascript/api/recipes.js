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

function updateRecipe(recipeId, recipe) {
  return (client
    .put(`/recipes/${recipeId}`,
      { recipe },
    ));
}

function getRecipeIngredients(recipeId) {
  return (client
    .get(`/recipes/${recipeId}/recipe_ingredients`, {
    }));
}

function getCriticalAssociations(recipeId) {
  return (client
    .get(`/recipes/${recipeId}/critical-associations`, {
    }));
}

export { getRecipes, getRecipe, deleteRecipe, postRecipe, updateRecipe, getRecipeIngredients, getCriticalAssociations };
