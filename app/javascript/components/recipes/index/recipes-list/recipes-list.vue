<template>
  <div class="flex flex-col flex-start p-0 static w-auto h-auto">
    <div class="flex-none order-2 flex-grow-0">
      <recipes-item
        v-for="recipe in allrecipes"
        :key="recipe.id"
        :recipe="recipe"
      />
    </div>
  </div>
</template>

<script>
import RecipesItem from './recipes-item';

export default {
  components: {
    RecipesItem,
  },
  props: {
    allrecipes: { type: Array, required: true },
  },
};
</script>
