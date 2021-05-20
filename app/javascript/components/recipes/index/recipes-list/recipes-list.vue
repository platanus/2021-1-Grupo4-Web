<template>
  <div class="flex flex-col flex-start p-0 static w-auto h-auto my-2">
    <div class="flex-none order-2 flex-grow-0">
      <recipes-item
        v-for="recipe in parsedElements"
        :key="recipe.name"
        :name="recipe.name"
        :portions="recipe.portions"
        :minutes="recipe.cook_minutes"
        :price="recipe.price"
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
  computed: {
    parsedElements() {
      return this.allrecipes.map((element) => JSON.parse(element));
    },
  },
};
</script>
