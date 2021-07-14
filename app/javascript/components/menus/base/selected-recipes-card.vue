<template>
  <div class="flex items-start justify-between w-full h-20 border border-gray-500 bg-gray-50">
    <!-- data -->
    <!-- Image -->
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <div class="flex flex-col items-start w-full h-16 mx-3 my-auto">
      <div class="h-6 font-hind font-bold text-lg text-black mb-0.5">
        {{ recipeSelected.name }}
      </div>
      <div class="flex items-center h-4">
        <div class=" h-4 font-hind font-normal text-xs text-gray-600 mr-2">
          {{ $t('msg.quantity') }}
        </div>
        <button
          class="w-3 h-3 rounded-sm bg-gray-200 shadow-sm mr-0.5 focus:outline-none"
          @click="decreaseQuantity"
        >
          <img
            class="h-3 w-3 text-white m-auto"
            svg-inline
            src="../../../../assets/images/minus-svg.svg"
          >
        </button>
        <div
          class="w-5 h-5 bg-gray-20 text-xs text-center my-auto"
        >
          {{ recipeSelected.quantity }}
        </div>
        <button
          class="w-3 h-3 rounded-sm bg-gray-200 shadow-sm ml-0.5 focus:outline-none"
          @click="increaseQuantity"
        >
          <img
            class="h-3 w-3 text-white m-auto"
            svg-inline
            src="../../../../assets/images/plus-svg.svg"
          >
        </button>
      </div>
    </div>
    <!-- button -->
    <div class="flex flex-col justify-center items-end h-20 flex-none self-stretch mr-2">
      <button
        class="w-4 h-4 bg-white-500 rounded-md mb-1.5 focus:outline-none"
        @click="deleteRecipe"
      >
        <img
          class="h-4 w-4 text-white m-auto"
          svg-inline
          src="../../../../assets/images/cross-svg.svg"
        >
      </button>
      <div class=" h-6 font-sans font-medium text-base text-right text-black flex-none">
        {{ recipePrice | currency }}
      </div>
    </div>
  </div>
</template>

<script>
import { getPriceOfSelectedIngredient } from '../../../utils/recipeUtils';

export default {
  data() {
    return {
      recipeQuantity: 0,
    };
  },
  props: {
    recipeSelected: { type: Object, required: true },
  },
  methods: {
    deleteRecipe() {
      this.$emit('delete-recipe', this.recipeSelected);
    },
    increaseQuantity() {
      this.$emit('increase-quantity', this.recipeSelected);
    },
    decreaseQuantity() {
      this.$emit('decrease-quantity', this.recipeSelected);
    },
    getPriceOfSelectedIngredient,
  },
  computed: {
    recipePrice() {
      const priceOfRecipe = this.recipeSelected.recipeIngredients.data.reduce((recipePrice, recipeIngredient) =>
        recipePrice + this.getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);

      return priceOfRecipe * this.recipeSelected.quantity;
    },
  },
};
</script>
