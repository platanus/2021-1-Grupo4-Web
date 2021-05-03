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
    <recipes :allrecipes="recipes" />
    <pagination />
  </div>
</template>

<script>
export default {
  props: {
    recipes: { type: Array, required: true },
  },
};
</script>
