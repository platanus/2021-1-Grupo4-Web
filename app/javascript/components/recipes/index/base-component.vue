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
    />
    <recipes :allrecipes="recipes" />
    <pagination />
    <!--Price Filter Modal-->
    <filter-popup
      @ok="filterByPrice"
      @cancel="toggleFilterByPriceModal"
      v-if="showingFilterByPrice"
      :title="Price"
      :min="Mínimo"
      :max="Máximo"
    >
      <p>{{ $t('msg.ingredients.deleteMsg') }}</p>
    </filter-popup>
    <!--Portions Filter Modal-->
    <filter-popup
      @ok="filterByPortions"
      @cancel="toggleFilterByPortionsModal"
      v-if="showingFilterByPortions"
      :title="Porciones"
      :min="Mínimas"
      :max="Máximas"
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
    filterByPrice() {
      this.showingFilterByPrice = !this.showingFilterByPrice;
    },
    toggleFilterByPortionsModal() {
      this.showingFilterByPortions = !this.showingFilterByPortions;
    },
    filterByPortions() {
      this.showingFilterByPortions = !this.showingFilterByPortions;
    },
  },
};
</script>
