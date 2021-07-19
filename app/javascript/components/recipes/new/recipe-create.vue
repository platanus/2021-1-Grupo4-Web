<template>
  <div class="flex flex-col">
    <!-- Tite -->
    <div class="flex items-center">
      <a :href="`/recipes`">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="text-4xl font-bold">
        {{ $t('msg.recipes.create') }}
      </div>
      <span
        class="flex m-auto w-8 h-8 ml-2"
        v-if="loading"
      >
        <base-spinner />
      </span>
    </div>

    <!-- Alert unexpected error -->
    <base-alert
      :variable="unexpectedError"
      :alert-name="'unexpectedError'"
      :success="false"
      @closeAlert="closeAlert"
    />

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
      <div class="flex flex-col xl:flex-row items-start justify-between mb-8 px-4">
        <div class="relative w-3/5 xl:w-2/5 py-2">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-1">
            {{ $t('msg.recipes.name') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="recipe.name"
          >
          <base-error-paragraph
            :msg-error="errors.name"
          />
        </div>
        <div class="relative w-2/5 xl:w-1/4 py-2">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-1">
            {{ $t('msg.recipes.portions') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="recipe.portions"
          >
          <base-error-paragraph
            :msg-error="errors.portions"
          />
        </div>
        <div class="relative w-2/5 xl:w-1/4 py-2">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-1">
            {{ $t('msg.recipes.preparation') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="recipe.cookMinutes"
          >
          <base-error-paragraph
            :msg-error="errors.cookMinutes"
          />
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
      <!-- pasos -->
      <div
        class="grid grid-cols-1 divide-y divide-gray-400"
      >
        <div class="mb-4">
          <recipe-steps
            :recipe-steps="recipe.steps.data"
            @new-step="addStep"
            @delete-step="deleteStep"
            @switch-steps="switchSteps"
          />
        </div>
        <div>
          <!--  botones -->
          <div class="flex items-start items-center mt-4">
            <button
              class="py-2 px-6 rounded shadow-md w-48 h-auto border border-gray-800 box-border drop-shadow rounded-md text-gray-800 mr-8"
              @click="cancelCreate"
            >
              {{ $t('msg.recipes.cancel') }}
            </button>
            <div>
              <base-button
                :elements="{ placeholder: $t('msg.recipes.add'),
                             color: 'bg-green-500 hover:bg-green-700 text-white' }"
                @click="createRecipe"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { postRecipe } from '../../../api/recipes.js';
import { geqZero, intNonZero, requiredField } from '../../../utils/validations.js';
import recipeIngredients from '../base/recipe-ingredients.vue';
import recipeSteps from '../base/recipe-steps.vue';

export default {
  components: {
    recipeIngredients,
    recipeSteps,
  },
  data() {
    return {
      loading: false,
      unexpectedError: false,
      recipe: {
        id: null,
        name: '',
        portions: '',
        cookMinutes: '',
        recipeIngredients: { data: [] },
        steps: { data: [] },
      },
      deletedRecipes: [],
      deletedSteps: [],
      errors: { name: '', portions: '', cookMinutes: '' },
    };
  },
  methods: {
    closeAlert() {
      this.unexpectedError = false;
    },
    cancelCreate() {
      window.location = '/recipes';
    },
    // por editar
    async createRecipe() {
      if (this.validations()) {
        try {
          this.loading = true;
          const recipeToCreate = this.getUpdatedRecipe();
          await postRecipe(recipeToCreate);
          window.location = '/recipes';
        } catch (error) {
          this.unexpectedError = true;
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
      const newRecipeIngredient = {
        attributes: { ingredientQuantity: 1, ingredientMeasure: ingredient.measure, ingredient: {} } };
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
          ingredientQuantity: recipeIngredient.attributes.ingredientQuantity || 1,
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
          mediaUrl: 'https://media_url',
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

    validations() {
      this.errors = { name: '', portions: '', cookMinutes: '' };

      this.errors.portions = intNonZero(this.recipe.portions, this.errors.portions);
      this.errors.cookMinutes = geqZero(this.recipe.cookMinutes, this.errors.cookMinutes);
      this.errors.name = requiredField(this.recipe.name, this.errors.name);
      this.errors.portions = requiredField(this.recipe.portions, this.errors.portions);
      this.errors.cookMinutes = requiredField(this.recipe.cookMinutes, this.errors.cookMinutes);

      return !(Object.values(this.errors).some(value => !!value));
    },
  },
};
</script>
