<template>
  <div class="flex items-center w-auto h-6 flex-grow-0 my-4">
    <!-- price -->
    <div class="flex items-center w-auto h-6 flex-grow-0 mr-8">
      <div>
        <img
          class="h-6 w-6 text-white mx-2"
          svg-inline
          src="../../../../assets/images/dollar-svg.svg"
        >
      </div>
      <div class="w-auto h-6 font-sans font-normal text-base text-black flex-grow-0">
        {{ recipePrice | currency }}
      </div>
    </div>
    <!-- portions -->
    <div class="flex items-center w-auto h-6 flex-grow-0 mr-4">
      <img
        class="h-6 w-6 text-white mr-2"
        svg-inline
        src="../../../../assets/images/chart-pie-svg.svg"
      >
      <div class="w-auto h-6 font-sans font-normal text-base text-black flex-grow-0">
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
      <div class="w-auto h-6 font-sans font-normal text-base text-black flex-grow-0">
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
    recipePrice: { type: Number, required: true },
  },
};
</script>
