<template>
  <div>
    <div class="flex flex-row justify-between items-center h-8 order-0 flex-grow-0 mt-1 mb-4">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.recipes.title') }}
      </div>
      <a
        class="flex flex-row justify-center items-center px-3 h-8 bg-blue-700 rounded order-1 flex-grow-0 text-white cursor-pointer"
        href="/recipes/new"
      >
        {{ $t('msg.recipes.add') }}
      </a>
    </div>
    <recipes-search-bar
      :placeholder="$t('msg.recipes.search')"
      :recipes="this.recipes"
      @filterByPrice="toggleFilterByPriceModal"
      @filterByPortions="toggleFilterByPortionsModal"
      @filterByName="updateRecipes"
    />
    <p
      class="my-4"
      v-if="recipes.length === 0"
    >
      {{ $t('msg.noElements') }} {{ $t('msg.recipes.title').toLowerCase() }}
    </p>
    <div v-else>
      <recipes-list
        :allrecipes="recipesToDisplay"
      />
    </div>
    <recipes-pagination />
    <!--Price Filter Modal-->
    <filter-popup
      @ok="toggleFilterByPriceModal"
      @cancel="toggleFilterByPriceModal"
      v-if="showingFilterByPrice"
      :title="$t('msg.recipes.filter.price')"
      :min="$t('msg.recipes.filter.minPrice')"
      :max="$t('msg.recipes.filter.maxPrice')"
    >
      <p>{{ $t('msg.ingredients.deleteMsg') }}</p>
    </filter-popup>
    <!--Portions Filter Modal-->
    <filter-popup
      @ok="toggleFilterByPortionsModal"
      @cancel="toggleFilterByPortionsModal"
      v-if="showingFilterByPortions"
      :title="$t('msg.recipes.filter.portions')"
      :min="$t('msg.recipes.filter.minPortions')"
      :max="$t('msg.recipes.filter.maxPortions')"
    >
      <p>{{ $t('msg.ingredients.deleteMsg') }}</p>
    </filter-popup>
  </div>
</template>

<script>

import { getRecipes } from '../../../api/recipes.js';
import FilterPopup from './filter-popup';
import RecipesSearchBar from './recipes-search-bar';
import RecipesPagination from './pagination/recipes-pagination';
import RecipesList from './recipes-list/recipes-list';

export default {
  components: {
    FilterPopup,
    RecipesSearchBar,
    RecipesPagination,
    RecipesList,
  },

  data() {
    return {
      recipes: [],
      recipesToDisplay: [],
      error: '',
      showingFilterByPrice: false,
      showingFilterByPortions: false,
    };
  },
  async created() {
    try {
      const response = await getRecipes();
      this.recipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.recipesToDisplay = this.recipes;
      this.error = '';
    } catch (error) {
      this.error = error;
    }
  },
  methods: {
    toggleFilterByPriceModal() {
      this.showingFilterByPrice = !this.showingFilterByPrice;
    },
    toggleFilterByPortionsModal() {
      this.showingFilterByPortions = !this.showingFilterByPortions;
    },
    updateRecipes(data) {
      this.recipesToDisplay = data;
    },
  },
};
</script>
