<template>
  <div class="flex flex-col items-start pt-4 min-w-min h-auto flex-grow-0 ml-2">
    <div class="w-28 h-6 font-sans font-normal text-lg text-black flex-grow-0 my-2.5">
      {{ $t('msg.ingredients.title') }}
    </div>
    <div class="flex flex-col items-start p-4 min-w-min bg-gray-200 rounded flex-grow-0 my-2.5">
      <recipe-ingredients-item
        v-for="recipeIngredient in recipeIngredients"
        :key="recipeIngredient.id"
        :ingredient="recipeIngredient.attributes.ingredient"
      />
    </div>
  </div>
</template>

<script>
import RecipeIngredientsItem from './recipe-ingredients-item';

export default {
  components: {
    RecipeIngredientsItem,
  },

  props: {
    recipeIngredients: { type: Array, required: true },
  },
};
</script>
