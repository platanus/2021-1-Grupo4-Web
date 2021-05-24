<template>
  <div>
    <!-- Price Filters -->
    <div>
      <p>
        {{ $t('msg.recipes.price') }}
      </p>
      <input
        class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:border-gray-600 focus:border-opacity-70 focus:ring focus:ring-gray-100 focus:ring-opacity-50"
        :placeholder="$t('msg.min')"
        v-model="filters.price.min"
      >
      <input
        class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:border-gray-600 focus:border-opacity-70 focus:ring focus:ring-gray-100 focus:ring-opacity-50"
        :placeholder="$t('msg.max')"
        v-model="filters.price.max"
      >
    </div>

    <!-- Portion Filters -->
    <div class="mt-6">
      <p>
        {{ $t('msg.recipes.portions') }}
      </p>
      <input
        class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:border-gray-600 focus:border-opacity-70 focus:ring focus:ring-gray-100 focus:ring-opacity-50"
        :placeholder="$t('msg.min')"
        v-model="filters.portions.min"
      >
      <input
        class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:border-gray-600 focus:border-opacity-70 focus:ring focus:ring-gray-100 focus:ring-opacity-50"
        :placeholder="$t('msg.max')"
        v-model="filters.portions.max"
      >
    </div>
  </div>
</template>

<script>

export default {
  data() {
    return {
      filters: {
        price: {
          min: '',
          max: '',
        },
        portions: {
          min: '',
          max: '',
        },
      },
    };
  },
};
</script>
