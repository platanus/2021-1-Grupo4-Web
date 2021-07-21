<template>
  <div class="flex items-start justify-between min-w-max h-20 border border-gray-500 bg-gray-50">
    <!-- data -->
    <div class="flex flex-col items-start w-auto h-16 mx-3 my-auto">
      <div class="h-6 font-hind font-bold text-lg text-black mb-0.5">
        {{ recipeIngredientAttrs.ingredient.name }}
      </div>
      <div class="flex items-center h-5 mb-0.5">
        <div class="h-5 font-hind font-light text-sm text-gray-600 mr-2">
          {{ $t('msg.recipes.price') }} {{ $t('msg.recipes.unitary') }}
        </div>
        <div class="h-5 font-hind font-normal text-sm text-black">
          {{ unitaryPrice | currency }}  por
          {{ recipeIngredientAttrs.ingredientMeasure }}
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
        <input
          class="w-8 h-5 bg-gray-20 text-xs text-center my-auto"
          v-model="ingredientQuantityData"
        >
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
    <div class="w-auto flex flex-col justify-center items-end h-20 flex-none self-stretch mr-2">
      <button
        class="w-4 h-4 bg-white-500 rounded-md mb-1.5 focus:outline-none"
        @click="deleteIngredient"
      >
        <img
          class="h-4 w-4 text-white m-auto"
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
import { unitaryPrice } from '../../../utils/recipeUtils.js';

export default {
  components: { baseDropdown },
  props: {
    recipeIngredientIdx: { type: Number, required: true },
    recipeIngredientAttrs: { type: Object, required: true },
  },

  data() {
    return {
      ingredientQuantityData: this.recipeIngredientAttrs.ingredientQuantity,
    };
  },

  methods: {
    deleteIngredient() {
      this.$emit('delete-ingredient', this.recipeIngredientIdx);
    },
    increaseQuantity() {
      this.ingredientQuantityData = parseFloat(this.ingredientQuantityData) + 1;
    },
    decreaseQuantity() {
      if (this.ingredientQuantityData <= 1) {
        this.deleteIngredient();
      }
      this.ingredientQuantityData = parseFloat(this.ingredientQuantityData) - 1;
    },
    changeMeasure(measure) {
      this.$emit('change-measure', measure, this.recipeIngredientIdx);
    },
    isInt(n) {
      return n % 1 === 0;
    },
  },
  computed: {
    unitaryPrice() {
      return unitaryPrice(this.recipeIngredientAttrs);
    },
    price() {
      return Math.round(this.recipeIngredientAttrs.ingredientQuantity *
      this.unitaryPrice);
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

  watch: {
    ingredientQuantityData() {
      this.$emit('change-quantity', this.recipeIngredientIdx, this.ingredientQuantityData);
    },
  },
};
</script>
