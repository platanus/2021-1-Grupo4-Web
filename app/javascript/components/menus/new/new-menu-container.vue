
<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.create') }}
      </div>
    </div>
    <div class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-4">
      <!-- Menu Name -->
      <div class="relative w-2/5 ml-4">
        <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
          {{ $t('msg.recipes.name') }}
        </div>
        <input
          class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
          v-model="menuName"
        >
      </div>
      <!-- Recipes -->
      <div class="flex justify-between mb-8">
        <div class="w-1/2 p-4">
          <div class="flex flex-col">
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
                class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0 focus:outline-none"
                :placeholder="$t('msg.recipes.search')"
                autocomplete="off"
              >
            </div>
            <!-- available recipes -->
            <div class="flex flex-col bg-gray-200 overflow-scroll">
              <add-recipe-card
                v-for="recipe in recipes"
                :key="recipe.id"
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
        </div>
        <!-- selected recipes -->
        <div class="w-1/2 p-4">
          <div class="flex flex-col self-stretch flex-grow bg-gray-50">
            <div class="flex h-6 bg-gray-50 font-sans font-medium text-base text-black self-stretch mb-3">
              {{ $t('msg.menus.selectedRecipes') }}
            </div>
            <div
              class="flex flex-col bg-gray-200 overflow-scroll"
              v-if="selectedRecipes.length > 0"
            >
              <div
                v-for="recipeSelected in selectedRecipes"
                :key="recipeSelected.id"
              >
                <selected-recipes-card
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
              v-else
            >
              {{ $t('msg.menus.noRecipes') }}
            </div>
            <div class="flex justify-end py-4 px-2 bg-gray-200 border border-gray-300 box-border self-stretch">
              <div class="w-auto h-6 font-bold text-base text-black mx-2">
                {{ $t('msg.menus.menuPrice') }} $ XXXXXXX
              </div>
            </div>
          </div>
          <button
            class="bg-green-500 hover:bg-green-700 text-white mx-2 my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 focus:outline-none"
            @click="createMenu"
          >
            {{ $t('msg.menus.create') }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecipes } from '../../../api/recipes.js';
import { postMenu } from '../../../api/menus.js';
import SelectedRecipesCard from './selected-recipes-card.vue';
import AddRecipeCard from './add-recipe-card';

export default {
  components: {
    SelectedRecipesCard,
    AddRecipeCard,
  },

  data() {
    return {
      recipes: [],
      error: '',
      query: '',
      menuName: '',
      selectedRecipes: [],
    };
  },

  computed: {
  },

  async created() {
    try {
      const response = await getRecipes();
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    }
  },

  methods: {
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
      const newValue = recipe.quantity -= 1;
      const indexToUpdate = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToUpdate, 1, { ...recipe, quantity: newValue });
    },

    async createMenu() {
      const menuRecipesToPost = this.selectedRecipes.map(element => (
        {
          recipeId: parseInt(element.id, 10),
          recipeQuantity: element.quantity,
        }
      ));
      const menuToPost = { name: this.menuName, menuRecipesAttributes: menuRecipesToPost };
      try {
        await postMenu(menuToPost);
        this.error = '';
        window.location.href = '/menus';
      } catch (error) {
        this.error = error;
      }
    },
  },
};
</script>
