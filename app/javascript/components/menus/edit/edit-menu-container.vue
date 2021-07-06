
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
        {{ menuName }}
      </div>
    </div>
    <div class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <div class="flex flex-row">
        <!-- Menu Name -->
        <div class="relative w-3/5 ml-4">
          <div class="text-gray-600 text-sm absolute bg-gray-50 px-1 left-2 -top-2">
            {{ $t('msg.recipes.name') }}
          </div>
          <input
            class="w-full h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
            v-model="menuName"
          >
          <p
            v-if="errors.name"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.${errors.name}`) }}
          </p>
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
          <p
            v-if="errors.portions"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.${errors.portions}`) }}
          </p>
        </div>
      </div>
      <!-- Recipes -->
      <div class="flex justify-between mb-8">
        <div class="w-1/2 p-4">
          <div class="flex flex-col w-full">
            <!-- search bar -->
            <div class="flex w-full relative text-yellow-700 my-4">
              <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                <img
                  svg-inline
                  src="../../../../assets/images/magnifyng-glass-svg.svg"
                  class="w-6 h-6 text-yellow-700"
                >
              </span>
              <input
                class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded focus:outline-none"
                :placeholder="$t('msg.recipes.search')"
                autocomplete="off"
                @keyup="filterRecipes"
                v-model="searchQuery"
              >
            </div>
            <!-- available recipes -->
            <div
              v-if="!loading"
              class="flex flex-col bg-gray-200 overflow-auto"
            >
              <add-recipe-card
                v-for="recipe in filterRecipes"
                :key="recipe.id"
                :name="recipe.name"
                :portions="recipe.portions"
                :minutes="recipe.cookMinutes"
                :selected-recipes="selectedRecipes"
                :id="recipe.id"
                :recipe-ingredients="recipe.recipeIngredients.data"
                @add="addRecipe(recipe)"
              >
                {{ recipe.name }}
              </add-recipe-card>
            </div>
            <span
              v-if="loading"
              class="flex my-auto w-8 h-8 pl-2 ml-2"
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
                class="flex my-auto w-8 h-8 pl-2 ml-2"
              >
                <base-spinner />
              </span>
            </div>
            <div
              class="flex flex-col bg-gray-200 overflow-auto"
              v-if="selectedRecipes.length > 0 && !loading"
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
              @click="editMenu"
            >
              {{ $t('msg.menus.saveChanges') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecipes } from '../../../api/recipes.js';
import { getMenu, updateMenu } from '../../../api/menus.js';
import SelectedRecipesCard from '../base/selected-recipes-card.vue';
import AddRecipeCard from '../base/add-recipe-card';
import { getPriceOfSelectedIngredient } from '../../../utils/recipeUtils';

export default {
  props: {
    menuId: { type: Number, required: true },
  },
  components: {
    SelectedRecipesCard,
    AddRecipeCard,
  },

  data() {
    return {
      loading: false,
      initialRecipes: [],
      recipes: [],
      error: false,
      query: '',
      menuName: '',
      menuPortions: '',
      selectedRecipes: [],
      deletedRecipes: [],
      searchQuery: '',
      errors: { name: '', portions: '' },
    };
  },
  computed: {
    totalMenuPrice() {
      const recipesPrices = this.selectedRecipes.map(element => ((
        element.recipeIngredients.data.reduce((recipePrice, recipeIngredient) =>
          recipePrice + getPriceOfSelectedIngredient(recipeIngredient.attributes), 0)
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
      const menuResponse = await getMenu(this.menuId);
      const response = await getRecipes();
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.useMenuInfo(menuResponse.data.data);
    } catch (error) {
      this.error = true;
    } finally {
      this.loading = false;
    }
  },
  methods: {
    async editMenu() {
      if (this.validations()) {
        this.loading = true;
        try {
          const updatedMenu = this.getUpdatedMenu();
          await updateMenu(this.menuId, updatedMenu);
          window.location = '/menus';
        } catch (error) {
          this.error = true;
        } finally {
          this.loading = false;
        }
      }
    },
    useMenuInfo(menu) {
      this.menuName = menu.attributes.name;
      this.menuPortions = menu.attributes.portions;
      this.initialRecipes = menu.attributes.menuRecipes.data.map(element => ({
        'quantity': element.attributes.recipeQuantity,
        'id': element.attributes.recipe.id,
        'idMenuRecipe': parseInt(element.id, 10),
      }));
      this.addInitialRecipes();
    },
    addInitialRecipes() {
      this.loading = true;
      try {
        const ids = this.initialRecipes.map(recipe => recipe.id);
        this.selectedRecipes = this.recipes.filter(recipe => ids.includes(parseInt(recipe.id, 10)));
        this.selectedRecipes.forEach(element => {
          const index = ids.indexOf(parseInt(element.id, 10));
          element.quantity = this.initialRecipes[index].quantity;
          element.idMenuRecipe = this.initialRecipes[index].idMenuRecipe;
        });
      } catch (error) {
        this.error = true;
      } finally {
        this.loading = false;
      }
    },
    addRecipe(recipe) {
      const defaultQuantity = 1;
      this.selectedRecipes.push({ ...recipe, quantity: defaultQuantity });
    },
    deleteRecipe(recipe) {
      const indexToRemove = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToRemove, 1);
      this.deletedRecipes.push(recipe);
    },
    increaseQuantity(recipe) {
      const newValue = recipe.quantity += 1;
      const indexToUpdate = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToUpdate, 1, { ...recipe, quantity: newValue });
    },
    decreaseQuantity(recipe) {
      if (recipe.quantity <= 1) return;
      const newValue = recipe.quantity -= 1;

      const indexToUpdate = this.selectedRecipes.findIndex((element) =>
        parseInt(element.id, 10) === parseInt(recipe.id, 10));
      this.selectedRecipes.splice(indexToUpdate, 1, { ...recipe, quantity: newValue });
    },
    getUpdatedMenu() {
      const updatedMenu = { name: this.menuName,
        portions: this.menuPortions };
      this.addMenuRecipeAttributes(updatedMenu);

      return updatedMenu;
    },
    addMenuRecipeAttributes(updatedMenu) {
      const menuRecipesAttributes = [];
      this.addNewAndUpdatedRecipes(menuRecipesAttributes);
      this.addDeletedMenuRecipes(menuRecipesAttributes);
      updatedMenu.menuRecipesAttributes = menuRecipesAttributes;
    },
    addNewAndUpdatedRecipes(menuRecipeAttributes) {
      for (const menuRecipe of this.selectedRecipes) {
        const hash = {
          recipeId: parseInt(menuRecipe.id, 10),
          recipeQuantity: menuRecipe.quantity,
        };
        if (!!menuRecipe.idMenuRecipe) {
          hash.id = menuRecipe.idMenuRecipe;
          // eslint-disable-next-line no-underscore-dangle
          hash._destroy = false;
        }
        menuRecipeAttributes.push(hash);
      }
    },
    addDeletedMenuRecipes(menuRecipeAttributes) {
      this.deletedRecipes.forEach(element => {
        menuRecipeAttributes.push(
          {
            id: element.idMenuRecipe,
            recipeId: parseInt(element.id, 10),
            recipeQuantity: element.quantity,
            _destroy: true,
          },
        );
      });
    },

    // eslint-disable-next-line max-statements,complexity
    validations() {
      this.errors = { name: '', portions: '' };

      if (!(Number.isInteger(this.menuPortions - 0)) || !(this.menuPortions > 0)) {
        this.errors.portions = 'intGeqZero';
      }

      if (!this.menuName) {
        this.errors.name = 'requiredField';
      }

      if (!this.menuPortions) {
        this.errors.portions = 'requiredField';
      }

      const validForm = !(Object.values(this.errors).some(value => !!value));

      return validForm;
    },
  },
};
</script>
