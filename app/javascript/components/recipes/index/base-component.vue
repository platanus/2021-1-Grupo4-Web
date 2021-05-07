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
    <search-recipe
      :placeholder="$t('msg.recipes.search')"
      @filterByPrice="toggleFilterByPriceModal"
      @filterByPortions="toggleFilterByPortionsModal"
    />
    <recipes :allrecipes="recipes" />
    <pagination />
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
export default {
  props: {
    recipes: { type: Array, required: true },
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
