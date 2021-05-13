<template>
  <div class="flex flex-row p-0 static w-auto h-auto flex-none order-1 flex-grow-0 mx-2.5 items-center">
    <div class="static font-sans not-italic font-normal text-2xl flex-none order-0 flex-grow-0 mx-2.5 text-blue-700">
      {{ "$ " + recipePrice }}
    </div>
    <a
      :href="`/recipes/${this.idRecipe}`"
      class="static w-5 h-5 flex-none order-1 flex-grow-0 mx-2.5"
    >
      <img
        class="h-5 w-5 text-white"
        svg-inline
        src="../../../../assets/images/keyboard-arrow-right-svg.svg"
      >
    </a>
  </div>
</template>

<script>
export default {
  props: {
    recipePrice: { type: Number, required: true },
    idRecipe: { type: String, required: true },
  },

};
</script>
