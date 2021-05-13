<template>
  <div class="flex flex-col flex-start p-0 static w-auto h-auto my-2">
    <div class="flex-none order-2 flex-grow-0">
      <recipe
        v-for="recipe in allrecipes"
        :key="recipe.id"
        :recipe="recipe"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    allrecipes: { type: Array, required: true },
  },
};
</script>
