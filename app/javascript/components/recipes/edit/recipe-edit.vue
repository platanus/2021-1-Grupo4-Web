<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center">
      <a :href="`/recipes/${recipeId}`">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="text-4xl font-bold">
        {{ recipe.name }}
      </div>
    </div>

    <!-- Alert -->
    <div
      v-if="error"
      class="mt-4 w-max bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative"
      role="alert"
    >
      <span class="mr-7 block sm:inline">{{ $t('msg.unexpectedError') }}</span>
      <span
        class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer"
        @click="closeAlert"
      >
        <img
          svg-inline
          src="../../../../assets/images/cancel-red-svg.svg"
          class="h-5 w-5 text-red-700"
        >
      </span>
    </div>

    <div
      v-if="!loading"
      class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-10"
    >
      <!-- Basic info -->
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
            <p
              v-if="errors.name"
              class="mt-2 ml-1 text-xs text-red-400"
            >
              {{ $t(`msg.${errors.name}`) }}
            </p>
          </div>
          <div class="relative w-1/4">
            <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
              {{ $t('msg.recipes.portions') }}
            </div>
            <input
              class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
              v-model="recipe.portions"
            >
            <p
              v-if="errors.portions"
              class="mt-2 ml-1 text-xs text-red-400"
            >
              {{ $t(`msg.${errors.portions}`) }}
            </p>
          </div>
          <div class="relative w-1/4">
            <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
              {{ $t('msg.recipes.preparation') }}
            </div>
            <input
              class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
              v-model="recipe.cookMinutes"
            >
            <p
              v-if="errors.cookMinutes"
              class="mt-2 ml-1 text-xs text-red-400"
            >
              {{ $t(`msg.${errors.cookMinutes}`) }}
            </p>
          </div>
        </div>
      </div>
      <!-- Ingredients -->
      <div class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8">
        2. {{ $t('msg.recipes.ingredients') }}
      </div>
      <recipe-ingredients
        :recipe-ingredients="recipe.recipeIngredients.data"
        @add-ingredient="addIngredient"
        @delete-ingredient="deleteIngredient"
        @change-quantity="changeQuantity"
        @change-measure="changeMeasure"
      />
      <!-- Steps -->
      <recipe-steps
        :recipe-steps="recipe.steps.data"
        @new-step="addStep"
        @delete-step="deleteStep"
        @switch-steps="switchSteps"
      />
      <!-- Buttons -->
      <div class="flex items-start items-center">
        <button
          class="py-2 px-6 rounded shadow-md w-auto h-auto border border-gray-800 box-border drop-shadow rounded-md text-gray-800 mr-8"
          @click="cancelEdit"
        >
          {{ $t('msg.recipes.cancel') }}
        </button>
        <div>
          <base-button
            :elements="{ placeholder: $t('msg.recipes.saveChanges'),
                         color: 'bg-green-500 hover:bg-green-700 text-white' }"
            @click="editRecipe"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecipe, updateRecipe } from '../../../api/recipes.js';
import { geqZero, intGeqZero, requiredField } from '../../../utils/validations.js';
import recipeIngredients from '../base/recipe-ingredients.vue';
import recipeSteps from '../base/recipe-steps.vue';

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
      loading: false,
      status: '',
      error: false,
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
      errors: { name: '', portions: '', cookMinutes: '' },
    };
  },
  async created() {
    this.loading = true;
    try {
      const response = await getRecipe(this.recipeId);
      this.recipe = { id: response.data.data.id, ...response.data.data.attributes };
      this.status = status;
    } catch (error) {
      this.error = true;
    } finally {
      this.loading = false;
    }
  },
  methods: {
    closeAlert() {
      this.error = false;
    },
    cancelEdit() {
      window.location = `/recipes/${this.recipeId}`;
    },
    async editRecipe() {
      if (this.validations()) {
        this.loading = true;
        try {
          const updatedRecipe = this.getUpdatedRecipe();
          await updateRecipe(this.recipe.id, updatedRecipe);
          window.location = `/recipes/${this.recipeId}`;
        } catch (error) {
          this.error = true;
        } finally {
          this.loading = false;
        }
      }
    },
    addIngredient(ingredient) {
      if (this.recipe.recipeIngredients.data.map(
        (recipeIngredient) => recipeIngredient.attributes.ingredient.id).includes(parseInt(ingredient.id, 10))) {
        return;
      }
      const newRecipeIngredient = { attributes: {
        ingredientQuantity: 1, ingredientMeasure: ingredient.measure, ingredient: {} } };
      newRecipeIngredient.attributes.ingredient = ingredient;
      this.recipe.recipeIngredients.data.push(newRecipeIngredient);
    },
    deleteIngredient(recipeIngredientIdx) {
      if (!!this.recipe.recipeIngredients.data[recipeIngredientIdx].id) {
        this.deletedRecipes.push(this.recipe.recipeIngredients.data[recipeIngredientIdx]);
      }
      this.recipe.recipeIngredients.data.splice(recipeIngredientIdx, 1);
    },
    changeQuantity(recipeIngredientIdx, ingredientQuantityData) {
      this.recipe.recipeIngredients.data[recipeIngredientIdx].attributes.ingredientQuantity = ingredientQuantityData;
    },
    changeMeasure(measure, recipeIngredientIdx) {
      this.recipe.recipeIngredients.data[recipeIngredientIdx].attributes.ingredientMeasure = measure;
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
          ingredientMeasure: recipeIngredient
            .attributes.ingredientMeasure || recipeIngredient.attributes.ingredient.measure,
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
    switchSteps(oldIndex, newIndex) {
      const oldData = this.recipe.steps.data[oldIndex];
      this.recipe.steps.data.splice(oldIndex, 1);
      this.recipe.steps.data.splice(newIndex, 0, oldData);
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

    // eslint-disable-next-line max-statements,complexity
    validations() {
      this.errors = { name: '', portions: '', cookMinutes: '' };

      this.errors.portions = intGeqZero(this.recipe.portions, this.errors.portions);
      this.errors.cookMinutes = geqZero(this.recipe.cookMinutes, this.errors.cookMinutes);
      this.errors.name = requiredField(this.recipe.name, this.errors.name);
      this.errors.portions = requiredField(this.recipe.portions, this.errors.portions);
      this.errors.cookMinutes = requiredField(this.recipe.cookMinutes, this.errors.cookMinutes);
      const validForm = !(Object.values(this.errors).some(value => !!value));

      return validForm;
    },

  },
};
</script>
