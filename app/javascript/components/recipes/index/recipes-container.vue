<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.recipes.title') }}
      </div>
    </div>

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- Search Bar and Add Button -->
      <div class="flex items-center pb-6">
        <div class="relative text-yellow-700">
          <span class="absolute inset-y-0 left-0 flex items-center pl-3">
            <img
              svg-inline
              src="../../../../assets/images/magnifyng-glass-svg.svg"
              class="w-6 h-6 text-yellow-700"
            >
          </span>
          <input
            class="my-4 py-2 pl-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0 focus:outline-none"
            :placeholder="$t('msg.recipes.search')"
            @keyup="filterRecipes"
            v-model="searchQuery"
          >
        </div>
        <a
          class="mx-2 my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 bg-green-500 hover:bg-green-700 text-white"
          href="/recipes/new"
        >
          {{ $t('msg.recipes.add') }}
        </a>
      </div>
      <!-- Filters -->
      <filters
        :filters="filters"
        :filter-options="filterOptions"
        @filters="toggleFiltersModal"
      />
      <!-- Content -->
      <p
        class="my-4"
        v-if="recipes.length === 0"
      >
        {{ $t('msg.noElements') }} {{ $t('msg.recipes.title').toLowerCase() }}
      </p>
      <div v-else>
        <recipes-list
          :allrecipes="filterRecipes()"
        />
      </div>

      <!--Pagination-->
      <recipes-pagination />
    </div>

    <!-- Filters Modal-->
    <base-modal
      @ok="updateFilters"
      @cancel="toggleFiltersModal"
      v-if="showingFiltersModal"
      :title="$t('msg.filters')"
      :ok-button-label="$t('msg.apply')"
      :cancel-button-label="$t('msg.deleteFilters')"
    >
      <filter-popup-content
        ref="filtersInfo"
      />
    </base-modal>
  </div>
</template>

<script>

import { getRecipes } from '../../../api/recipes.js';
import Filters from './filters';
import FilterPopupContent from './filter-popup-content';
import RecipesPagination from './pagination/recipes-pagination';
import RecipesList from './recipes-list/recipes-list';

export default {
  components: {
    Filters,
    FilterPopupContent,
    RecipesPagination,
    RecipesList,
  },

  data() {
    return {
      recipes: [],
      recipesToDisplay: [],
      searchQuery: '',
      filters: { price: { min: '', max: '' }, portions: { min: '', max: '' } },
      filterOptions: ['price', 'portions'],
      error: '',
      showingFiltersModal: false,
    };
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
    toggleFiltersModal() {
      this.showingFiltersModal = !this.showingFiltersModal;
    },
    updateFilters() {
      this.showingFiltersModal = !this.showingFiltersModal;
      this.filters = this.$refs.filtersInfo.filters;
    },
    updateRecipes(data) {
      this.recipesToDisplay = data;
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
};
</script>
