import axios from 'axios';

async function getRecipes(email, token) {
  return (axios
    .get('/api/v1/recipes', {
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

async function postRecipe(newRecipe, email, token) {
  return (axios
    .post('/api/v1/recipes', {
      recipe: {
        'name': newRecipe.name,
        'portions': newRecipe.portions,
        'instructions': newRecipe.instructions,
        'cook_minutes': newRecipe.cookMinutes,
      },
    }, { params: {
      'user_email': email,
      'user_token': token,
    } }));
}

async function deleteRecipe(email, token, recipeId) {
  return (axios
    .delete(`/api/v1/recipes/${recipeId}`, {
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

async function editRecipe(email, token, recipeId, recipeInfo) {
  return (axios
    .put(`/api/v1/recipes/${recipeId}`, {
      recipe: {
        'name': recipeInfo.name,
        'portions': recipeInfo.portions,
        'instructions': recipeInfo.instructions,
        'cook_minutes': recipeInfo.cookMinutes,
      },
    }, {
      params: {
        'user_email': email,
        'user_token': token,
      },
    }));
}

export { getRecipes, postRecipe, deleteRecipe, editRecipe };
