<template>
  <div class="flex items-center w-auto h-6 flex-grow-0 my-4">
    <!-- price -->
    <div class="flex items-center w-auto h-6 flex-grow-0 mr-8">
      <img
        class="h-6 w-6 text-white mx-2"
        svg-inline
        src="../../../../assets/images/dollar-svg.svg"
      >
      <div class="w-10 h-5 font-sans font-normal text-base text-black flex-grow-0">
        {{ getPrice }}
      </div>
    </div>
    <!-- portions -->
    <div class="flex items-center w-auto h-6 flex-grow-0 mr-4">
      <img
        class="h-6 w-6 text-white mr-2"
        svg-inline
        src="../../../../assets/images/chart-pie-svg.svg"
      >
      <div class="w-24 h-5 font-sans font-normal text-base text-black flex-grow-0">
        {{ portions }} {{ $t('msg.recipes.portions') }}
      </div>
    </div>
    <!-- minutes -->
    <div class="flex items-center w-auto h-6 flex-grow-0 mr-8 ml-1">
      <img
        class="h-6 w-6 text-white mr-2"
        svg-inline
        src="../../../../assets/images/clock-svg.svg"
      >
      <div class="w-36 h-5 font-sans font-normal text-base text-black flex-grow-0">
        {{ cookMinutes }} {{ $t('msg.recipes.minutes') }}
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: {
    portions: { type: Number, required: true },
    cookMinutes: { type: Number, required: true },
    ingredients: { type: Array, required: true },
  },
  methods: {
    ingredientFinalPrice(quantity, price) {
      return (quantity * price);
    },
  },
  computed: {
    getPrice() {
      return this.ingredients.map(element => this.ingredientFinalPrice(element.quantity, element.price)).reduce((acc, curVal) => acc + curVal, 0);
    },
  },
};
</script>
