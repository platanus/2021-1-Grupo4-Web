<template>
  <div class="flex flex-row justify-start items-center p-0 static w-min-content h-12 flex-none order-1 flex-grow-0 mt-6">
    <div class="flex my-4 items-center justify-start">
      <form method="GET">
        <div class="relative text-yellow-700">
          <span class="absolute inset-y-0 left-0 flex items-center pl-2">
            <button
              type="submit"
              class="p-1 focus:outline-none focus:shadow-outline"
            >
              <img
                svg-inline
                src="../../../../assets/images/magnifyng-glass-svg.svg"
                class="w-6 h-6 text-yellow-700"
              >
            </button>
          </span>
          <input
            type="search"
            name="q"
            class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0"
            :placeholder="placeholder"
            autocomplete="off"
          >
        </div>
      </form>
    </div>
    <button
      class="flex flex-row items-center justify-center px-3 py-3 static w-auto h-8 bg-white border-2 border-solid
      border-blue-700 box-border rounded-full flex-none order-1 flex-grow-0 mx-2.5 text-blue-700"
      @click="filterByPrice()"
    >
      {{ $t('msg.recipes.price') }}
    </button>
    <button
      class="flex flex-row items-center justify-center px-3 py-3 static w-auto h-8 border-2 border-solid
      border-blue-700 box-border rounded-full flex-none order-2 flex-grow-0 mx-2.5 bg-blue-700 text-white"
      @click="filterByPortions()"
    >
      {{ $t('msg.recipes.portions') }}
    </button>
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, required: true },
  },
  methods: {
    filterByPrice() {
      this.$emit('filterByPrice');
    },
    filterByPortions() {
      this.$emit('filterByPortions');
    },
  },
};
</script>
