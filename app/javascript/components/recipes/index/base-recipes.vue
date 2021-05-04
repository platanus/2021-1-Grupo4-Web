<template>
  <div class="flex flex-col flex-start p-0 static w-auto h-auto my-2">
    <div class="flex-none order-2 flex-grow-0">
      <recipe
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
export default {
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
