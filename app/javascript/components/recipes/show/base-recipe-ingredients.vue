<template>
  <div class="flex flex-col items-start pt-4 min-w-min h-auto flex-grow-0 ml-2">
    <div class="w-28 h-6 font-sans font-normal text-lg text-black flex-grow-0 my-2.5">
      {{ $t('msg.ingredients.title') }}
    </div>
    <div class="flex flex-col items-start p-4 min-w-min bg-gray-200 rounded flex-grow-0 my-2.5">
      <recipe-ingredient
        v-for="ingredient in ingredients"
        :key="ingredient.id"
        :ingredient="ingredient"
      />
    </div>
  </div>
</template>

<script>

export default {
  props: {
    ingredients: { type: Array, required: true },
  },
};
</script>
