<template>
  <div>
    <div class="flex flex-col">
      <div class="flex items-center h-8 mt-1">
        <!--Title-->
        <a href="/ingredients">
          <img
            class="h-6 w-6 text-white mr-2"
            svg-inline
            src="../../../assets/images/arrow-left-svg.svg"
          >
        </a>
        <div class="text-4xl font-bold">
          {{ $t('msg.ingredients.inventory.editingInventories') }}
        </div>
      </div>
      <div class="flex flex-col p-10 w-auto bg-gray-50 my-10">
        <!--SearchBar-->
        <div class="flex flex-col lg:flex-row pb-4">
          <div class="flex items-center lg:w-1/3">
            <div class="relative text-yellow-700 w-full">
              <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                <img
                  svg-inline
                  src="../../../assets/images/magnifyng-glass-svg.svg"
                  class="w-6 h-6 text-yellow-700"
                >
              </span>
              <input
                class="w-full py-2 pl-12 bg-gray-50 border-2 border-gray-600 rounded self-stretch focus:outline-none z-200"
                :placeholder="$t('msg.ingredients.search')"
                v-model="searchQuery"
              >
            </div>
          </div>
        </div>
        <div
          class="w-auto m-auto"
          v-if="loading"
        >
          <span
            class="flex w-12 h-12 ml-2"
          >
            <base-spinner />
          </span>
        </div>
        <!--Table-->
        <div v-if="!loading">
          <p
            v-if="this.ingredients.length===0"
            class="p-2"
          >
            {{ $t('msg.noElements') }} {{ $t('msg.ingredients.title').toLowerCase() }}
          </p>
          <div
            v-else
            class="flex flex-col w-full 2xl:justify-center items-center overflow-auto"
          >
            <inventory-table
              :ingredients="ingredients"
              :search-query="searchQuery"
              @updateIngredientInventory="updateIngredientInventory"
            />
          </div>
          <div class="flex justify-end">
            <div class="flex min-w-min my-4">
              <base-button
                :elements="{ placeholder: $t('msg.saveChanges'),
                             color: 'bg-green-500 hover:bg-green-700 text-white min-w-min' }"
                @click="updateInventory"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import { getIngredients, editInventories } from './../../api/ingredients.js';
import InventoryTable from './inventory-table';

export default {

  data() {
    return {
      loading: false,
      showingSearchIngredients: false,
      ingredientsToEdit: [],
      ingredients: [],
      marketIngredient: undefined,
      searchQuery: '',
      error: '',
    };
  },

  components: {
    InventoryTable,
  },
  async created() {
    this.loading = true;
    try {
      const response = await getIngredients();
      this.ingredients = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
    } catch (error) {
      this.error = error;
    } finally {
      this.loading = false;
    }
    this.roundInventory();
  },

  methods: {
    updateIngredientInventory(ingredient) {
      this.ingredientsToEdit.push(ingredient);
    },
    async updateInventory() {
      try {
        const formattedIngredients = this.ingredientsToEdit.map((ingredient) => ({
          ingredientId: ingredient.id, inventory: ingredient.finalInventory,
        }));

        if (formattedIngredients.length) {
          await editInventories(formattedIngredients);
        }

        window.location = '/ingredients';
      } catch (error) {
        this.error = error;
      }
    },
    roundInventory() {
      this.ingredients.forEach(ingredient => {
        ingredient.inventory = Math.round(ingredient.inventory * '100') / '100';
      });
    },
  },
};
</script>
