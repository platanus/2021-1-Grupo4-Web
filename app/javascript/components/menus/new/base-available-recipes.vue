<template>
  <div class="flex flex-col items-start w-min-w self-stretch flex-grow-0">
    <div class="min-w-min h-10 bg-gray-500 border border-gray-500 self-stretch flex-grow-0 py-2 px-6 font-hind font-normal text-white text-base">
      {{ $t('msg.menus.recipes') }}
    </div>
    <recipe-card />
    <recipe-card />
    <recipe-card />
    <recipe-card />
  </div>
</template>

<script>
import RecipeCard from './base-recipe-card.vue';

export default {
  components: {
    RecipeCard,
  },
};
</script>
