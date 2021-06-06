<template>
  <div class="flex flex-row justify-start items-center p-0 static w-min-content h-12 flex-none flex-grow-0">
    <!-- Filter Button -->
    <button
      class="flex-row border-2 border-gray-800 rounded-lg px-6 focus:outline-none"
      @click="filtersButtonClick()"
    >
      <img
        svg-inline
        src="../../../../assets/images/filter-svg.svg"
        class="h-6 w-6 inline-block"
      >
      <span class="inline-block">
        {{ $t('msg.filters') }}
      </span>
    </button>
    <!-- Filters -->
    <div
      v-for="filter in filterOptions"
      :key="filter"
      class="flex flex-row inline-block items-center justify-center px-3 py-3 static w-auto h-8
      rounded-full flex-none flex-grow-0 mx-2.5 bg-yellow-500 text-white"
    >
      {{ filters[filter].min }} &lt; {{ $t(`msg.recipes.${filter}`) }} &lt; {{ filters[filter].max }}
    </div>
    <!-- <div
      v-if="showPriceFilter"
      class="flex flex-row inline-block items-center justify-center px-3 py-3 static w-auto h-8
      rounded-full flex-none flex-grow-0 mx-2.5 bg-yellow-500 text-white"
    >
    {{ filters[price].min }} &lt; {{ $t(`msg.recipes.price`) }} &lt; {{ filters[price].max }}
    </div> -->
  </div>
</template>

<script>
export default {
  props: {
    filters: { type: Object, required: true },
    filterOptions: { type: Array, required: true },
  },

  methods: {
    filtersButtonClick() {
      this.$emit('filters');
    },
  },
  data() {
    return {
      showPriceFilter: false,
      showPortionsFilter: false,
    };
  },
  created() {
    if (this.filters.price.min !== '' || this.filters.price.max !== '') {
      this.showPriceFilter = true;
    }
    if (this.filters.portions.min !== '' || this.filters.portions.max !== '') {
      this.showPortionsFilter = true;
    }
  },
};
</script>
