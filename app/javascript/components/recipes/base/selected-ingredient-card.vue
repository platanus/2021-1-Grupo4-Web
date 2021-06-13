<template>
  <div class="flex items-start justify-between w-full h-20 border border-gray-500 bg-gray-50">
    <!-- data -->
    <div class="flex flex-col items-start w-full h-16 mx-3 my-auto">
      <div class="h-6 font-hind font-bold text-lg text-black mb-0.5">
        {{ recipeIngredientAttrs.ingredient.name }}
      </div>
      <div class="flex items-center  h-5 mb-0.5">
        <div class="h-5 font-hind font-light text-sm text-gray-600 mr-0.5">
          {{ $t('msg.recipes.price') }} {{ $t('msg.recipes.unitary') }}
        </div>
        <div class="h-5 font-hind font-normal text-sm text-black">
          $ {{ recipeIngredientAttrs.ingredient.price / recipeIngredientAttrs.ingredient.quantity }} CLP por
          {{ recipeIngredientAttrs.ingredient.measure }}
        </div>
      </div>
      <div class="flex items-center h-4">
        <div class=" h-4 font-hind font-normal text-xs text-gray-600 mr-2">
          {{ $t('msg.ingredients.quantity') }}
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
          {{ recipeIngredientAttrs.ingredientQuantity }}
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
        <base-dropdown
          class="mx-2"
          :elements="units"
          @select="changeMeasure"
        />
      </div>
    </div>
    <!-- button -->
    <div class="flex flex-col justify-center items-end h-20 flex-none self-stretch mr-2">
      <button
        class="w-3 h-3 bg-red-500 shadow-sm rounded-md flex-none flex-grow-0 mb-1.5 focus:outline-none"
        @click="deleteIngredient"
      >
        <img
          class="h-3 w-3 text-white m-auto"
          svg-inline
          src="../../../../assets/images/cross-svg.svg"
        >
      </button>
      <div class=" h-6 font-sans font-medium text-base text-right text-black flex-none flex-grow-0">
        $ {{ price }}
      </div>
    </div>
  </div>
</template>

<script>
import baseDropdown from '../../base/base-dropdown.vue';

export default {
  components: { baseDropdown },
  props: {
    recipeIngredientIdx: { type: Number, required: true },
    recipeIngredientAttrs: { type: Object, required: true },
  },
  methods: {
    deleteIngredient() {
      this.$emit('delete-ingredient', this.recipeIngredientIdx);
    },
    increaseQuantity() {
      this.$emit('increase-quantity', this.recipeIngredientIdx);
    },
    decreaseQuantity() {
      this.$emit('decrease-quantity', this.recipeIngredientIdx);
    },
    changeMeasure(measure) {
      this.$emit('change-measure', measure, this.recipeIngredientIdx);
    },
  },
  computed: {
    price() {
      return this.recipeIngredientAttrs.ingredientQuantity *
      this.recipeIngredientAttrs.ingredient.price / this.recipeIngredientAttrs.ingredient.quantity;
    },
    units() {
      let ingredientUnits = this.recipeIngredientAttrs
        .ingredient.otherMeasures.data.map(element => element.attributes.name);
      if (this.recipeIngredientAttrs.ingredientMeasure) {
        ingredientUnits = ingredientUnits.filter(item => item !== this.recipeIngredientAttrs.ingredientMeasure);
        ingredientUnits.unshift(this.recipeIngredientAttrs.ingredientMeasure);
      }

      return ingredientUnits;
    },
  },
};
</script>
