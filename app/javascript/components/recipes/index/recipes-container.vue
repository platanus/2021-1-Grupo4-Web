<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center">
      <div class="text-4xl font-bold">
        {{ $t('msg.recipes.title') }}
      </div>
    </div>

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- searchBar y button -->
      <div class="flex flex-col lg:flex-row pb-4">
        <div class="flex items-center py-2 pr-2 lg:w-1/2">
          <div class="relative text-yellow-700 w-full">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <img
                svg-inline
                src="../../../../assets/images/magnifyng-glass-svg.svg"
                class="w-6 h-6 text-yellow-700"
              >
            </span>
            <input
              class="w-full py-2 pl-12 bg-gray-50 border-2 border-gray-600 rounded self-stretch focus:outline-none z-200"
              :placeholder="$t('msg.recipes.search')"
              v-model="searchQuery"
            >
          </div>
        </div>
        <div class="flex justify-end w-full">
          <a
            class="my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 bg-green-500 hover:bg-green-700 text-white"
            href="/recipes/new"
          >
            {{ $t('msg.recipes.add') }}
          </a>
        </div>
      </div>
      <!-- Filters -->
      <filters
        :filters="filters"
        :filter-options="filterOptions"
        @filters="toggleFiltersModal"
        @deletePrice="toggleDeletePriceByCross"
        @deletePortions="toggleDeletePortionsByCross"
      />
      <!-- Content -->
      <span
        class="flex m-auto w-8 h-8 ml-2 mt-4"
        v-if="loading"
      >
        <base-spinner />
      </span>
      <div
        class="mt-4"
        v-if="!loading"
      >
        <p
          v-if="recipes.length === 0"
        >
          {{ $t('msg.noElements') }} {{ $t('msg.recipes.title').toLowerCase() }}
        </p>
        <div v-else>
          <recipes-list
            :allrecipes="filteredRecipes"
          />
        </div>
      </div>
      <!--Pagination-->
      <recipes-pagination />
    </div>

    <!-- Filters Modal-->
    <base-modal
      @ok="updateFilters"
      @cancel="toggleDeleteFilters"
      v-if="showingFiltersModal"
      :title="$t('msg.filters')"
      :ok-button-label="$t('msg.apply')"
      :cancel-button-label="$t('msg.deleteFilters')"
    >
      <filter-popup-content
        ref="filtersInfo"
        :actualfilters="filters"
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
import { getPriceOfSelectedIngredient } from '../../../utils/recipeUtils';

export default {
  components: {
    Filters,
    FilterPopupContent,
    RecipesPagination,
    RecipesList,
  },

  data() {
    return {
      loading: false,
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
    this.loading = true;
    try {
      const response = await getRecipes();
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    } finally {
      this.loading = false;
    }
  },
  computed: {
    // eslint-disable-next-line max-statements
    makeFiltersToCompare() {
      const filtersToCompare = { price: { min: '', max: '' }, portions: { min: '', max: '' } };
      if (this.filters.price.min === '') {
        filtersToCompare.price.min = 0;
      } else {
        filtersToCompare.price.min = this.filters.price.min;
      }
      if (this.filters.price.max === '') {
        filtersToCompare.price.max = 9999999999999;
      } else {
        filtersToCompare.price.max = this.filters.price.max;
      }
      if (this.filters.portions.min === '') {
        filtersToCompare.portions.min = 0;
      } else {
        filtersToCompare.portions.min = this.filters.portions.min;
      }
      if (this.filters.portions.max === '') {
        filtersToCompare.portions.max = 99999999999999;
      } else {
        filtersToCompare.portions.max = this.filters.portions.max;
      }

      return filtersToCompare;
    },
    filteredRecipes() {
      if (this.searchQuery) {
        // Los 4 filtros con busqueda
        return this.recipes.filter(recipe => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => recipe.name.toLowerCase().includes(text)) &&
          this.calculateRecipePrice(recipe) >= this.makeFiltersToCompare.price.min &&
           this.calculateRecipePrice(recipe) <= this.makeFiltersToCompare.price.max &&
            recipe.portions >= this.makeFiltersToCompare.portions.min &&
          recipe.portions <= this.makeFiltersToCompare.portions.max);
      }
      // Los 4 filtros sin busqueda
      if (this.makeFiltersToCompare.price.min !== '' && this.makeFiltersToCompare.price.max !== '' &&
      this.makeFiltersToCompare.portions.max !== '' && this.makeFiltersToCompare.portions.min !== '') {
        return this.recipes.filter(recipe => this.calculateRecipePrice(recipe) >=
          this.makeFiltersToCompare.price.min && this.calculateRecipePrice(recipe) <=
          this.makeFiltersToCompare.price.max && recipe.portions >= this.makeFiltersToCompare.portions.min &&
          recipe.portions <= this.makeFiltersToCompare.portions.max);
      }

      return this.recipes;
    },

  },

  methods: {
    calculateRecipePrice(recipe) {
      return recipe.recipeIngredients.data
        .reduce((recipePrice, recipeIngredient) => recipePrice +
          getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);
    },
    toggleFiltersModal() {
      this.showingFiltersModal = !this.showingFiltersModal;
    },
    toggleDeleteFilters() {
      this.filters.portions.min = '';
      this.filters.portions.max = '';
      this.filters.price.min = '';
      this.filters.price.max = '';
      this.showingFiltersModal = !this.showingFiltersModal;
    },
    toggleDeletePriceByCross() {
      this.filters.price.min = '';
      this.filters.price.max = '';
    },
    toggleDeletePortionsByCross() {
      this.filters.portions.min = '';
      this.filters.portions.max = '';
    },
    updateFilters() {
      this.showingFiltersModal = !this.showingFiltersModal;
      this.filters = this.$refs.filtersInfo.filters;
    },
  },
};
</script>
