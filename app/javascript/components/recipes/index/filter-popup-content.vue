<template>
  <div>
    <!-- Price Filters -->
    <div>
      <p>
        {{ $t('msg.recipes.price') }}
      </p>
      <input
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border roundedflex-grow-0 my-1"
        :placeholder="$t('msg.min')"
        v-model="filters.price.min"
      >
      <input
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
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
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border roundedflex-grow-0 my-1"
        :placeholder="$t('msg.min')"
        v-model="filters.portions.min"
      >
      <input
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
        :placeholder="$t('msg.max')"
        v-model="filters.portions.max"
      >
    </div>
  </div>
</template>

<script>

export default {
  props: {
    actualfilters: { type: Object, required: true },
  },
  data() {
    return {
      filters: this.actualfilters,
    };
  },
};
</script>
