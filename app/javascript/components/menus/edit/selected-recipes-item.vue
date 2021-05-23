<template>
  <div class="flex items-center pr-4">
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <div>
      <p class="py-2 px-3 font-medium">
        {{ recipe.name }}
      </p>
      <div>
        <p class="py-2 px-3 text-xs inline-block">
          {{ recipe.portions }} {{ $t('msg.recipes.portions') }}
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          $XX.XXX CLP
        </p>
        <img
          svg-inline
          src="../../../../assets/images/plus-svg.svg"
          class="h-6 w-6"
        >
        <img
          svg-inline
          src="../../../../assets/images/minus-svg.svg"
          class="h-6 w-6"
        >
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: Object, required: true },
  },

};
</script>
