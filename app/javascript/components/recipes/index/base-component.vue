<template>
  <div>
    <div class="flex flex-row justify-between items-center h-8 order-0 flex-grow-0 mt-1 mb-4">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.recipes.title') }}
      </div>
      <span class="flex flex-row justify-center items-center px-3 h-8 bg-blue-700 rounded order-1 flex-grow-0 text-white">
        {{ $t('msg.recipes.add') }}
      </span>
    </div>
    <search-recipe :placeholder="$t('msg.recipes.search')" />
    <p
      class="my-4"
      v-if="this.recipes.length===0"
    >
      {{ $t('msg.noElements') }} {{ $t('msg.recipes.title').toLowerCase() }}
    </p>
    <div v-else>
      <recipes
        :allrecipes="this.recipes"
      />
      <pagination />
    </div>
  </div>
</template>

<script>

import { getRecipes } from './../../../api/recipes.js';

export default {
  data() {
    return {
      recipeToEdit: {},
      recipeToDelete: {},
      recipes: [],
      status: '',
      error: '',
    };
  },
  async created() {
    const token = localStorage.getItem('token');
    const email = localStorage.getItem('email');
    try {
      const response = await getRecipes(email, token);
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
    }
  },
  methods: {
    async successResponse(response) {
      this.status = response.status;
      this.error = '';
    },
    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  },
  data() {
    return {
      showingFilterByPrice: false,
      showingFilterByPortions: false,
    };
  },
  methods: {
    toggleFilterByPriceModal() {
      this.showingFilterByPrice = !this.showingFilterByPrice;
    },
    toggleFilterByPortionsModal() {
      this.showingFilterByPortions = !this.showingFilterByPortions;
    },
  },
};
</script>
