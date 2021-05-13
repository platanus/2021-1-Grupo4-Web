<template>
  <div class="flex flex-row justify-between items-center p-6 static h-24 bg-white border-2 border-solid border-gray-400 box-border my-2 flex-none flex-grow-0 self-stretch m-0">
    <info-recipe
      :recipe-name="recipe.name"
      :recipe-portions="recipe.portions"
      :recipe-minutes="recipe.cookMinutes"
    />
    <price-recipe
      :recipe-price="5000"
      :id-recipe="recipe.id"
    />
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: Object, required: true },
  },
};
</script>
