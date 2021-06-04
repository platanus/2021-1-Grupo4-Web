<template>
  <div class="flex flex-col">
    <!-- nombre -->
    <div class="flex items-center">
      <a :href="`/recipes/${recipeId}`">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="h-7 font-sans font-lg text-2xl text-black font-bold flex-grow">
        {{ recipe.name }}
      </div>
    </div>
    <!-- cuadro blanco edición -->
    <div class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-4">
      <!-- datos básicos -->
      <div
        class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8"
      >
        1. {{ $t('msg.recipes.basic') }}
      </div>
      <div class="flex flex-col">
        <div class="flex items-start justify-between h-16 flex-none self-stretch flex-grow-0 mb-8">
          <div class="relative w-2/5">
            <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
              {{ $t('msg.recipes.name') }}
            </div>
            <input
              class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
              v-model="recipe.name"
            >
          </div>
          <div class="relative w-1/4">
            <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
              {{ $t('msg.recipes.portions') }}
            </div>
            <input
              class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
              v-model="recipe.portions"
            >
          </div>
          <div class="relative w-1/4">
            <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
              {{ $t('msg.recipes.preparation') }}
            </div>
            <input
              class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
              v-model="recipe.cookMinutes"
            >
          </div>
        </div>
      </div>
      <!-- ingredients -->
      <div class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8">
        2. {{ $t('msg.recipes.ingredients') }}
      </div>
      <recipe-ingredients
        :recipe-ingredients="recipe.recipeIngredients.data"
        @add-ingredient="addIngredient"
        @delete-ingredient="deleteIngredient"
        @increase-quantity="increaseQuantity"
        @decrease-quantity="decreaseQuantity"
      />
      <!-- pasos -->
      <recipe-steps
        :recipe-steps="recipe.steps.data"
        @new-step="addStep"
        @delete-step="deleteStep"
      />
      <!--  botones -->
      <div class="flex items-start w-auto h-11 flex-none self-stretch flex-grow-0">
        <button 
          class="flex justify-center items-center py-2.5 px-10 w-auto h-11 border border-gray-800 box-border drop-shadow rounded-md font-sans font-normal text-base text-gray-800 flex-none flex-grow-0 mr-8"
          @click="cancelEdit"
        >
          {{ $t('msg.recipes.cancel') }}
        </button>
        <button
          class="flex justify-center items-center py-2.5 px-10 w-auto h-11 bg-green-500 shadow rounded-md font-sans font-normal text-base text-white flex-none flex-grow-0"
          @click="editRecipe"
        >
          {{ $t('msg.recipes.saveChanges') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecipe, updateRecipe } from '../../../api/recipes.js';
import recipeIngredients from './recipe-ingredients.vue';
import recipeSteps from './recipe-steps.vue';

export default {
  props: {
    recipeId: { type: Number, required: true },
  },
  components: {
    recipeIngredients,
    recipeSteps,
  },
  data() {
    return {
      status: '',
      error: '',
      recipe: {
        id: null,
        name: '',
        portions: 0,
        cookMinutes: 0,
        recipeIngredients: { data: [] },
        steps: { data: [] },
      },
      deletedRecipes: [],
      deletedSteps: [],
    };
  },
  async created() {
    try {
      const response = await getRecipe(this.recipeId);
      this.recipe = { id: response.data.data.id, ...response.data.data.attributes };
      this.status = status;
    } catch (error) {
      this.error = error;
    }
  },
  methods: {
    cancelEdit() {
      window.location = `/recipes/${this.recipeId}`;
    },
    async editRecipe() {
      try {
        const updatedRecipe = this.getUpdatedRecipe();
        await updateRecipe(this.recipe.id, updatedRecipe);
        window.location = `/recipes/${this.recipeId}`;
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },
    addIngredient(ingredient) {
      if (this.recipe.recipeIngredients.data.map(
        (recipeIngredient) => recipeIngredient.attributes.ingredient.id).includes(parseInt(ingredient.id, 10))) {
        return;
      }
      const newRecipeIngredient = { attributes: { ingredientQuantity: 1, ingredient: {} } };
      newRecipeIngredient.attributes.ingredient = ingredient;
      this.recipe.recipeIngredients.data.push(newRecipeIngredient);
    },
    deleteIngredient(recipeIngredientIdx) {
      if (!!this.recipe.recipeIngredients.data[recipeIngredientIdx].id) {
        this.deletedRecipes.push(this.recipe.recipeIngredients.data[recipeIngredientIdx]);
      }
      this.recipe.recipeIngredients.data.splice(recipeIngredientIdx, 1);
    },
    increaseQuantity(recipeIngredientIdx) {
      this.recipe.recipeIngredients.data[recipeIngredientIdx].attributes.ingredientQuantity += 1;
    },
    decreaseQuantity(recipeIngredientIdx) {
      if (this.recipe.recipeIngredients.data[recipeIngredientIdx].attributes.ingredientQuantity === 1) {
        this.deleteIngredient(recipeIngredientIdx);

        return;
      }
      this.recipe.recipeIngredients.data[recipeIngredientIdx].attributes.ingredientQuantity -= 1;
    },
    getUpdatedRecipe() {
      const updatedRecipe = { name: this.recipe.name,
        cookMinutes: this.recipe.cookMinutes, portions: this.recipe.portions };

      this.addUpdatedRecipeIngredients(updatedRecipe);
      this.addUpdatedSteps(updatedRecipe);

      return updatedRecipe;
    },
    addUpdatedRecipeIngredients(updatedRecipe) {
      const recipeIngredientsAttributes = [];

      this.addNewAndUpdatedRecipes(recipeIngredientsAttributes);
      this.addDeletedRecipeIngredients(recipeIngredientsAttributes);
      updatedRecipe.recipeIngredientsAttributes = recipeIngredientsAttributes;
    },
    addNewAndUpdatedRecipes(recipeIngredientsAttributes) {
      for (const recipeIngredient of this.recipe.recipeIngredients.data) {
        const hash = {
          ingredientId: recipeIngredient.attributes.ingredient.id,
          ingredientQuantity: recipeIngredient.attributes.ingredientQuantity,
        };
        if (!!recipeIngredient.id) {
          hash.id = recipeIngredient.id;
        }
        recipeIngredientsAttributes.push(hash);
      }
    },
    addDeletedRecipeIngredients(recipeIngredientsAttributes) {
      for (const recipeIngredient of this.deletedRecipes) {
        recipeIngredientsAttributes.push(
          {
            id: recipeIngredient.id,
            _destroy: true,
          },
        );
      }
    },
    addStep(stepDescription) {
      const newStep = { attributes: { description: stepDescription } };
      this.recipe.steps.data.push(newStep);
    },
    deleteStep(stepIdx) {
      if (!!this.recipe.steps.data[stepIdx].id) {
        this.deletedSteps.push(this.recipe.steps.data[stepIdx]);
      }
      this.recipe.steps.data.splice(stepIdx, 1);
    },
    addUpdatedSteps(updatedRecipe) {
      const stepsAttributes = [];

      this.addNewAndUpdatedSteps(stepsAttributes);
      this.addDeletedSteps(stepsAttributes);

      updatedRecipe.stepsAttributes = stepsAttributes;
    },
    addNewAndUpdatedSteps(stepsAttributes) {
      for (const step of this.recipe.steps.data) {
        const hash = {
          description: step.attributes.description,
        };
        if (!!step.id) {
          hash.id = step.id;
        }
        stepsAttributes.push(hash);
      }
    },
    addDeletedSteps(stepsAttributes) {
      for (const step of this.deletedSteps) {
        stepsAttributes.push(
          {
            id: step.id,
            _destroy: true,
          },
        );
      }
    },
  },
};
</script>
