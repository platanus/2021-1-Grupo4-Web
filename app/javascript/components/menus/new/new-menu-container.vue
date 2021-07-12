
<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center">
      <a :href="`/menus`">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="text-4xl font-bold">
        {{ $t('msg.menus.create') }}
      </div>
    </div>

    <!-- Alert unexpected error -->
    <base-alert
      :variable="error"
      :alert-name="'unexpectedError'"
      :success="false"
      @closeAlert="closeAlert"
    />

    <div class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- Menu Name -->
      <div class="flex flex-row justify-between">
        <div class="relative w-3/5 ml-4">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
            {{ $t('msg.recipes.name') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="menuName"
          >
          <base-error-paragraph
            :msg-error="errors.name"
          />
        </div>
        <!-- Menu Portions -->
        <div class="relative w-2/5 ml-4">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
            {{ $t('msg.recipes.portions') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="menuPortions"
          >
          <base-error-paragraph
            :msg-error="errors.portions"
          />
        </div>
      </div>
      <!-- Recipes -->
      <div class="flex justify-between mb-8">
        <div class="w-1/2 p-4">
          <div class="flex flex-col w-auto">
            <!-- search bar -->
            <div class="relative text-yellow-700 my-4">
              <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                <img
                  svg-inline
                  src="../../../../assets/images/magnifyng-glass-svg.svg"
                  class="w-6 h-6 text-yellow-700"
                >
              </span>
              <input
                class="flex py-2 px-12 w-full h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0 focus:outline-none"
                :placeholder="$t('msg.recipes.search')"
                autocomplete="off"
                @keyup="filterRecipes"
                v-model="searchQuery"
              >
            </div>
            <!-- available recipes -->
            <div
              v-if="!loading && filterRecipes.length > 0"
              class="flex flex-col h-96 bg-gray-200 overflow-scroll"
            >
              <div class="min-w-max">
                <add-recipe-card
                  v-for="recipe in filterRecipes"
                  :key="recipe.id"
                  :selected-recipes="selectedRecipes"
                  :id="recipe.id"
                  :name="recipe.name"
                  :portions="recipe.portions"
                  :minutes="recipe.cookMinutes"
                  :recipe-ingredients="recipe.recipeIngredients.data"
                  @add="addRecipe(recipe)"
                >
                  {{ recipe.name }}
                </add-recipe-card>
              </div>
            </div>
            <div
              class="flex h-6 bg-gray-50 font-sans font-light text-base text-black self-stretch mb-3"
              v-else
            >
              {{ $t('msg.menus.noRecipesAvailable') }}
            </div>
            <span
              v-if="loading"
              class="flex m-auto w-8 h-8 ml-2"
            >
              <base-spinner />
            </span>
          </div>
        </div>
        <!-- selected recipes -->
        <div class="w-1/2 p-4">
          <div class="flex flex-col self-stretch flex-grow bg-gray-50">
            <div class="flex h-6 bg-gray-50 font-sans font-medium text-base text-black self-stretch mb-3">
              {{ $t('msg.menus.selectedRecipes') }} ({{ selectedRecipes.length }})
              <span
                v-if="loading"
                class="flex m-auto w-8 h-8 ml-2"
              >
                <base-spinner />
              </span>
            </div>
            <div
              class="flex flex-col h-96 bg-gray-200 overflow-scroll"
              v-if="selectedRecipes.length > 0 && !loading"
            >
              <div
                class="min-w-max"
              >
                <selected-recipes-card
                  v-for="recipeSelected in selectedRecipes"
                  :key="recipeSelected.id"
                  :recipe-selected="recipeSelected"
                  @delete-recipe="deleteRecipe"
                  @increase-quantity="increaseQuantity"
                  @decrease-quantity="decreaseQuantity"
                >
                  {{ recipeSelected.name }}
                </selected-recipes-card>
              </div>
            </div>
            <div
              class="flex h-6 bg-gray-50 font-sans font-light text-base text-black self-stretch mb-3"
              v-if="!selectedRecipes.length > 0 && !loading"
            >
              {{ $t('msg.menus.noRecipes') }}
            </div>
            <div class="flex justify-end py-4 px-2 bg-gray-200 border border-gray-300 box-border self-stretch">
              <div class="w-auto h-6 font-bold text-base text-black mx-2">
                {{ $t('msg.menus.menuPrice') }} {{ totalMenuPrice | currency }}
              </div>
            </div>
          </div>
          <div class="flex justify-end">
            <button
              class="bg-green-500 hover:bg-green-700 text-white my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 focus:outline-none"
              @click="createMenu"
            >
              {{ $t('msg.menus.create') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecipes } from '../../../api/recipes.js';
import { postMenu } from '../../../api/menus.js';
import { intNonZero, requiredField } from '../../../utils/validations.js';
import SelectedRecipesCard from '../base/selected-recipes-card.vue';
import AddRecipeCard from '../base/add-recipe-card';
import { getPriceOfSelectedIngredient } from '../../../utils/recipeUtils';

export default {
  components: {
    SelectedRecipesCard,
    AddRecipeCard,
  },

  data() {
    return {
      loading: false,
      recipes: [],
      query: '',
      menuName: '',
      menuPortions: '',
      selectedRecipes: [],
      searchQuery: '',
      errors: { name: '', portions: '' },
      error: false,
    };
  },

  computed: {
    totalMenuPrice() {
      const recipesPrices = this.selectedRecipes.map(element => ((
        element.recipeIngredients.data.reduce((recipePrice, recipeIngredient) =>
          recipePrice + this.getPriceOfSelectedIngredient(recipeIngredient.attributes), 0)
      ) * element.quantity),
      );

      return recipesPrices.reduce((menuPrice, recipePrice) =>
        menuPrice + recipePrice, 0);
    },
    filterRecipes() {
      if (this.searchQuery) {
        return this.recipes.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.recipes;
    },
  },

  async created() {
    this.loading = true;
    try {
      const response = await getRecipes();
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
    } catch (error) {
      this.error = true;
    } finally {
      this.loading = false;
    }
  },

  methods: {
    getPriceOfSelectedIngredient,
    addRecipe(recipe) {
      const defaultQuantity = 1;
      this.selectedRecipes.push({ ...recipe, quantity: defaultQuantity });
    },
    deleteRecipe(recipe) {
      const indexToRemove = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToRemove, 1);
    },
    increaseQuantity(recipe) {
      const newValue = recipe.quantity += 1;
      const indexToUpdate = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToUpdate, 1, { ...recipe, quantity: newValue });
    },
    decreaseQuantity(recipe) {
      if (recipe.quantity <= 1) {
        this.deleteRecipe(recipe);
      } else {
        const newValue = recipe.quantity -= 1;
        const indexToUpdate = this.selectedRecipes.findIndex((element) =>
          parseInt(element.id, 10) === parseInt(recipe.id, 10));
        this.selectedRecipes.splice(indexToUpdate, 1, { ...recipe, quantity: newValue });
      }
    },

    async createMenu() {
      if (this.validations()) {
        const menuRecipesToPost = this.selectedRecipes.map(element => (
          {
            recipeId: parseInt(element.id, 10),
            recipeQuantity: element.quantity,
          }
        ));
        const menuToPost = {
          name: this.menuName,
          menuRecipesAttributes: menuRecipesToPost,
          portions: this.menuPortions,
        };
        try {
          await postMenu(menuToPost);
          window.location.href = '/menus';
        } catch (error) {
          this.error = true;
        }
      }
    },

    closeAlert() {
      this.error = false;
    },

    validations() {
      this.errors = { name: '', portions: '' };

      this.errors.portions = intNonZero(this.menuPortions, this.errors.portions);
      this.errors.name = requiredField(this.menuName, this.errors.name);
      this.errors.portions = requiredField(this.menuPortions, this.errors.portions);

      return !(Object.values(this.errors).some(value => !!value));
    },
  },
};
</script>
