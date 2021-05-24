<template>
  <div class="flex items-start h-16 w-auto self-stretch flex-grow-0">
    <!-- recipe photo -->
    <div class="flex items-center p-1 w-16 h-16 self-stretch flex-grow-0 bg-red-300" />
    <!-- recipe data -->
    <recipe-selected-data />
  </div>
</template>

<script>
import RecipeSelectedData from './recipe-selected-data.vue';

export default {
  components: {
    RecipeSelectedData,
  },
};
</script>
